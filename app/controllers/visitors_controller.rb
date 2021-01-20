class VisitorsController < ApplicationController
  before_action :check_user, except: [:events, :search]
  before_action :is_searchable, only: [:search]

  def index
    @user = User.new
    @success_stories = SuccessStory.all.where(approved: true)
    # @resource = params[:resource] if params[:resource].present?
  end

  def search
    filter_users
    @liked_users =  current_user.liked_users.pluck(:user_id) rescue []
  end

  def events
    @events = Event.all
  end

  private

  def check_user
    if current_user && current_user.user?
      redirect_to dashboard_index_path
    elsif current_user && current_user.admin?
      redirect_to admin_dashboard_index_path
    end
  end

  def is_searchable
    unless current_user
      redirect_to root_path
    end
  end
end
