class LikesController < BaseController
  before_action :load_user, only: %i[create like_back]

  def index
    @likes = current_user.likes.includes(:liker).order(created_at: :desc)
    @likes.unseen.update_all(seen: true)
  end

  def create
    return if @user.blank? || current_user.blank?

    @like = Like.find_or_initialize_by(user_id: @user.id, liker_id: current_user.id)
    if @like.new_record?
      @like.save
      UserMailer.profile_liked(@user, current_user).deliver_now
    end
  end

  def like_back
    return if @user.blank? || current_user.blank?

    @like = Like.find_or_initialize_by(user_id: @user.id, liker_id: current_user.id)
    if @like.new_record?
      @like.save
      UserMailer.profile_liked(@user, current_user).deliver_now
    end
    flash[:success] = 'Profile liked'
    redirect_to likes_path
  end

  private

  def load_user
    @user = User.find_by(id: params[:user_id])
  end
end
