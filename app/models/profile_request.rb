class ProfileRequest < ApplicationRecord
  belongs_to :user,   class_name: 'User', foreign_key: :user_id
  belongs_to :requester, class_name: 'User', foreign_key: :requester_id

  scope :unapproved, -> { where(approved: false) }
end
