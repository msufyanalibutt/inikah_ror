class Like < ApplicationRecord
  belongs_to :user,  class_name: 'User', foreign_key: :user_id
  belongs_to :liker, class_name: 'User', foreign_key: :liker_id

  scope :unseen, -> { where(seen: false) }
end
