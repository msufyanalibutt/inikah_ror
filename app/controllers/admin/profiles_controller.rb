module Admin
  class ProfilesController < BaseController
    
    def edit
    	@profile = current_user
    end

    def show
    	@profile = current_user
    end

    def update
    	@profile = current_user
    	@profile.attributes = user_params
    	if @profile.save(validate: false)
	      flash[:success] = 'Profile Updated Successfully'
	      redirect_to admin_profile_path(@profile)
	    else
	      render :edit
	    end
    end

    private
    def user_params
    	unless params[:profile][:password].blank?
	    	params.require(:profile).permit(:first_name, :phone_number, :last_name, :username, :password, images: [])
    	else
    		params.require(:profile).permit(:first_name, :phone_number, :last_name, :username, images: [])
    	end
	  end
  end
end
