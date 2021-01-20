class Contact < ApplicationRecord
  validates :name, :email, :message, presence: true
  validates :email, format: { with: Devise::email_regexp }
  validates :message, length: { minimum: 5, maximum: 200 }
end
