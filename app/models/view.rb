class View < ApplicationRecord
  belongs_to :user,   class_name: 'User', foreign_key: :user_id
  belongs_to :viewer, class_name: 'User', foreign_key: :viewer_id

  scope :unseen, -> { where(seen: false) }
end
