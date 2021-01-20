module MessagesHelper
  def my_messages_count
    message_ids = Conversation.includes(:messages).get_all(current_user).pluck('messages.id')
    Message.where(id: message_ids, seen: false).where.not(sender_id: current_user.id).count rescue 0
  end

  def unread_messages_per_conversation_count(conversation)
    conversation.messages.where(seen: false).where.not(sender_id: current_user.id).count rescue 0
  end
end
