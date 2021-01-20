module Admin
  class ProfileRequestsController < BaseController

    def index
      @profile_requests = ProfileRequest.all
    end

    def approve
      @profile_request = ProfileRequest.find(params[:id])
      @profile_request.update(approved: true)
      UserMailer.profile_request_approved(@profile_request.user, @profile_request.requester).deliver_now
      flash[:success] = 'Request approved'
      redirect_to admin_profile_requests_path
    end
  end
end
