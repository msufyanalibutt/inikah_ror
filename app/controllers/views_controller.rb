class ViewsController < BaseController
  def index
    @views = current_user.views.includes(:viewer).order(created_at: :desc)
    @views.unseen.update_all(seen: true)
  end
end
