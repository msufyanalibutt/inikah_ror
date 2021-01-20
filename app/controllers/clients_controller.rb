class ClientsController < BaseController
  before_action :load_user,  only: %i[edit update show]
  before_action :count_view, only: %i[show]
  before_action :check_profile_request, only: %i[show]

  def update
    if @client.update_attributes(user_params)
      redirect_to client_path(@client)
    else
      render :edit
    end
  end

  private

  def load_user
    @client = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:abount_me, :religion, :height, :weight, :education, :job_title, :hobbies,
                                 :native, :annual_income, :skin_tone, :family_background, :expectations,
                                 :age, :marital_status, images: [])
  end

  def count_view
    user_view = View.find_or_initialize_by(user_id: @client.id, viewer_id: current_user.id) if @client != current_user
    if user_view&.new_record?
      user_view.save
      UserMailer.profile_viewed(@client, current_user).deliver_now
    end
  end

  def check_profile_request
    user_request = ProfileRequest.find_or_initialize_by(user_id: @client.id, requester_id: current_user.id) if @client != current_user
    if user_request.present?
      if user_request&.new_record?
        user_request.save
        UserMailer.profile_requested(@client, current_user).deliver_now
      end
      unless user_request&.approved?
        redirect_to root_path, alert: 'You request to view this user has been sent to Admin. We will inform you as soon as the request gets approved'
      end
    end
  end
end
