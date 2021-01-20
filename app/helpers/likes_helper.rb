module LikesHelper
  def my_likes_count
    current_user.likes.unseen.count rescue 0
  end
end
