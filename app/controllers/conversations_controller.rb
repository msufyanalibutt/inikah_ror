class ConversationsController < BaseController
  before_action :check_chat_request, only: %i[create show]

  def create
    @sender = User.find(params[:sender])
    @receiver = User.find(params[:receiver])
    c_id = @sender.get_conversation(@receiver)
    if c_id.any?
      conversation =  Conversation.find(c_id.first.id)
    else
      conversation =  @sender.sender_conversations.create(receiver_id: @receiver.id)
    end
    if conversation
      @conversation = conversation
      c = conversation.messages.new(note: params[:note], sender_id: @sender.id)
      if c.save
        if conversation.sender == current_user
          @member = conversation.receiver
          UserMailer.message_received(@member, current_user, c.note).deliver_now
        elsif conversation.receiver == current_user
          @member = conversation.sender
          UserMailer.message_received(@member, current_user, c.note).deliver_now
        end
        if c.sender == @member
          status = 'sender'
        else
          status = 'receiver'
        end
        if @conversation.sender == c.sender
          other = @conversation.receiver
        else
          other = @conversation.sender
        end

        image_url = polymorphic_url(c.sender.images.last) rescue nil
        ActionCable.server.broadcast 'chat_messages_channel', conversation: conversation.id, message: c.note, sender: @sender.id, status: status, other_id: other.username, image_url: image_url
        respond_to do |format|
          format.html { redirect_to conversation_path(conversation), notice: 'Message sent successfully' }
          format.js
        end
      else
        respond_to do |format|
          format.html { redirect_to client_path(@receiver) }
          format.js
        end
      end
    end
  end

  def index
    @conversations = Conversation.get_all(@current_user.id)
    @user = current_user
  end

  def show
    @conversation = Conversation.find(params[:id])
    @user = current_user
    if @conversation.sender == current_user
      @member = @conversation.receiver
    elsif @conversation.receiver == current_user
      @member = @conversation.sender
    end
    @conversation.messages.where(seen: false).where.not(sender_id: current_user.id).update_all(seen: true)
    @message_count = @conversation.messages.where(seen: false).where.not(sender_id: current_user.id).count
  end

  def update
    @conversation = Conversation.find(params[:id])
    @user = current_user
    if @conversation.sender == current_user
      @member = @conversation.receiver
    elsif @conversation.receiver == current_user
      @member = @conversation.sender
    end
    @conversation.messages.where(seen: false).where.not(sender_id: current_user.id).update_all(seen: true)
    @message_count = @conversation.messages.where(seen: false).where.not(sender_id: current_user.id).count
  end

  private
  def check_chat_request
    if params[:sender].present? && params[:receiver].present?
      @sender = User.find(params[:sender])
      @receiver = User.find(params[:receiver])
      c_id = @sender.get_conversation(@receiver)
      if c_id.any?
        @conversation =  Conversation.find(c_id.first.id)
      else
        @conversation =  @sender.sender_conversations.create(receiver_id: @receiver.id)
      end
    else
      @conversation = Conversation.find(params[:id])
    end
    if @conversation.sender == current_user
      @member = @conversation.receiver
    elsif @conversation.receiver == current_user
      @member = @conversation.sender
    end
    


    user_request = ChatRequest.find_by(user_id: @member.id, requester_id: current_user.id) if @member != current_user
    
    user_request = ChatRequest.find_by(user_id: current_user.id, requester_id: @member.id) if user_request.blank?
    
    user_request = ChatRequest.new(user_id: current_user.id, requester_id: @member.id) if user_request.blank?

    if user_request.new_record?
      user_request.save
      UserMailer.chat_requested(@member, current_user).deliver_now
    end
    unless user_request.approved?
      redirect_to root_path, alert: 'You request to chat this user has been sent to Admin. We will inform you as soon as the request gets approved'
    end
  end
end
