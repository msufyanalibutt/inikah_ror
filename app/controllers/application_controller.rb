class ApplicationController < ActionController::Base
  before_action :set_header_links
  after_action :prepare_unobtrusive_flash

  include SearchConcern

  def set_header_links
    @resource        = User.new
  end

  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_dashboard_index_path
    elsif resource.user?
      dashboard_index_path
    end
  end
end
