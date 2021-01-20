module Admin
  class ChatRequestsController < BaseController

    def index
      @chat_requests = ChatRequest.all
    end

    def approve
      @chat_request = ChatRequest.find(params[:id])
      @chat_request.update(approved: true)
      UserMailer.chat_request_approved(@chat_request.user, @chat_request.requester).deliver_now
      flash[:success] = 'Request approved'
      redirect_to admin_chat_requests_path
    end
  end
end
