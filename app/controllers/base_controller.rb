class BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :client?

  private

  def client?
    redirect_to root_path, alert: 'You are not authorized to access this page' unless current_user
  end
end
