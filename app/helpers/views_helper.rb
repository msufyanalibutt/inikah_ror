module ViewsHelper
  def my_views_count
    current_user.views.unseen.count rescue 0
  end
end
