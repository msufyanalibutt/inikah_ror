module Admin
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :admin?

    layout 'admin'

    private
    def admin?
      redirect_to root_path, alert: 'You are not authorized to access this page' unless current_user.admin?
    end
  end
end
