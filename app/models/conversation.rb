class Conversation < ApplicationRecord
  belongs_to :receiver, :class_name => "User"
  belongs_to :sender, :class_name => "User"

  has_many :messages

  scope :between, -> (sender_id, receiver_id) do
    where(sender_id: sender_id, receiver_id: receiver_id).or(
      where(sender_id: receiver_id, receiver_id: sender_id)
    )
  end
  
  scope :between_all, -> (user_id) do
    where(sender_id: user_id).or(
      where(receiver_id: user_id)
    )
  end

  def chat_user(user)
    if self.sender == user
      self.receiver
    else
      self.sender
    end
  end

  def self.get(sender_id, receiver_id)
    conversations = between(sender_id, receiver_id)
    conversations
  end

  def self.get_all(user_id)
    conversations = between_all(user_id)
    conversations
  end
end
