class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  enum role:   %w[user admin]
  enum gender: %w[husband wife]

  attr_accessor :password_changed

  VALID_EMAIL_REGEX = '[^@\s]+@(?:[-a-zA-Z0-9]+\.)+[a-z]{2,}'
  NATIVE            = ['English', 'Urdu']
  EDUCATION         = ['High School', 'Some College', 'Associate Degree', 'Bacholers Degree', 'Masters', 'PHD/post doctoral']
  RELIGION          = ['African Traditional & Diasporic', 'Agnostic', 'Atheist', "Baha'i", 'Buddhism', 'Cao Dai', 'Chinese traditional religion', 'Christianity', 'Hinduism', 'Islam', 'Jainism', 'Juche', 'Judaism', 'Neo-Paganism', 'Non-religious', 'Rastafarianism', 'Secular', 'Shinto', 'Sikhism', 'Spiritism', 'Tenrikyo', 'Unitarian-Universalism', 'Zoroastrianism', 'Primal-indigenous', 'Other']
  MARITAL_STATUS    = ['Single', 'Married', 'Widowed', 'Divorced']
  SKIN_TONE         = ['Black', 'Dark', 'Dark Brown', 'Fair', 'Light', 'Light Brown', 'Mmedium', 'Medium Brown', 'Olive', 'Ruddy', 'Sallow', 'other']

  has_many_attached :images
  has_many :sender_conversations, class_name: 'Conversation', foreign_key: 'sender_id'
  has_many :receiver_conversations, class_name: 'Conversation', foreign_key: 'receiver_id'
  has_many :likes,        class_name: 'Like', foreign_key: :user_id
  has_many :liked_users,  class_name: 'Like', foreign_key: :liker_id
  has_many :views,        class_name: 'View', foreign_key: :user_id
  has_many :viewed_users, class_name: 'View', foreign_key: :viewer_id

  has_many :profile_requests,        class_name: 'ProfileRequest', foreign_key: :user_id
  has_many :requested_users, class_name: 'ProfileRequest', foreign_key: :requester_id

  has_many :chat_requests,        class_name: 'ChatRequest', foreign_key: :user_id
  has_many :chat_requested_users, class_name: 'ChatRequest', foreign_key: :requester_id

  has_many :success_stories

  validates :username, :dob, :first_name, :last_name, :gender, :city, :country, presence: true, unless: :password_changed
  validates :email, presence: true, format: { with: Regexp.new("\\A#{VALID_EMAIL_REGEX}\\z") }, unless: :password_changed
  validates :phone_number, numericality: { only_integer: true }, unless: :password_changed
  validates :annual_income, numericality: { only_integer: true, message: 'is not valid. Please enter a valid income amount' }, on: :update, unless: :password_changed
  validates :age, numericality: { greater_than_or_equal_to: 10, less_than_or_equal_to: 150,  only_integer: true, message: 'is not valid. Please enter a valid age' }, on: :update, unless: :password_changed 
  validates :height, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 10, message: 'is not valid. Please enter a valid height' }, on: :update, unless: :password_changed
  validates :weight, numericality: { greater_than_or_equal_to: 10, less_than_or_equal_to: 600, message: 'is not valid. Please enter a valid weight' }, on: :update, unless: :password_changed

  def get_conversation(user_b)
    second_user = user_b.id
    total = self.sender_conversations + self.receiver_conversations
    results = total.select{|a| a.sender_id.eql?(second_user) || a.receiver_id.eql?(second_user)}
  end

  def all_conversation
    self.sender_conversations + self.receiver_conversations
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def devise_mailer
    UserDeviseMailer
  end

  def active_for_authentication?
    super and self.active?
  end

  def inactive_message
    active? ? super : :not_valid
  end
end
