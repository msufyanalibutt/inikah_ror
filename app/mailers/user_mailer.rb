class UserMailer < ApplicationMailer
  include Rails.application.routes.url_helpers

  def send_account_details(user, password)
    @user = user
    @password = password
    mail( to: @user.email, subject: 'Account Details' )
  end

  def profile_viewed(user, viewer)
  	@user = user
  	@viewer = viewer
    mail( to: @user.email, subject: 'Profile Viewed' )
  end

  def message_received(receiver, sender, message)
  	@receiver = receiver
  	@sender = sender
  	@message = message
    mail( to: @receiver.email, subject: 'New Message' )
  end

  def profile_liked(user, liker)
  	@user = user
  	@liker = liker
    mail( to: @user.email, subject: 'Profile Liked' )
  end

  def profile_requested(user, requester)
    @user = user
    @requester = requester
    mail( to: @user.email, subject: 'Profile View Request' )
  end

  def profile_request_approved(user, requester)
    @user = user
    @requester = requester
    mail( to: @requester.email, subject: 'Profile View Request Approved' )
  end

  def chat_request_approved(user, requester)
    @user = user
    @requester = requester
    mail( to: @requester.email, subject: 'Chat Request Approved' )
  end

  def chat_requested(user, requester)
    @user = user
    @requester = requester
    mail( to: @user.email, subject: 'Chat Request' )
  end
  
  def attachment_request_approved(requester)
    @requester = requester
    mail( to: @requester.email, subject: 'Attachment Request Approved' )
  end

  def success_story_approved(requester)
    @requester = requester
    mail( to: @requester.email, subject: 'Success Story Request Approved' )
  end
end
