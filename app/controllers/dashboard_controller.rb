class DashboardController < BaseController

  def index
    @users = User.all.where.not(id: current_user.id).where.not(gender: current_user.gender, role: 'admin')
    @liked_users =  current_user.liked_users.pluck(:user_id)
  end
end
