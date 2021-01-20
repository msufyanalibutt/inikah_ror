module Admin
  class UsersController < BaseController
  	before_action :load_user, except: :index

    def index
      @users = User.all.where.not(role: 'admin')
    end

    def show
    end

    def edit
    end

    def update
    	if @client.update_attributes(user_params)
	      flash[:success] = 'User Profile Updated Successfully'
	      redirect_to admin_users_path
	    else
	      render :edit
	    end
    end

    def destroy
    	@client.destroy
	    flash[:success] = 'User Profile has been deleted'
	    redirect_to admin_users_path
    end

    def edit_password
    end

    def update_password
    	@client.password_changed = true
	    if @client.update(password_params)
	      bypass_sign_in(current_user)
	    	flash[:success] = 'User Password changed Successfully'
	      redirect_to admin_users_path
	    else
	    	flash[:error] = 'Unable to change user password'
	      render "edit_password"
	    end
	  end

	  def block
	  	if params[:flag] == 'active'
	  		@client.update_attribute('active', true)
	    	flash[:success] = 'User activated Successfully'
	  	else
	  		@client.update_attribute('active', false)
	    	flash[:success] = 'User blocked Successfully'
	  	end
	    redirect_to admin_users_path
	  end

	  def verify
	  	@client.update_attribute('verified', true)
	    flash[:success] = 'User is verified'
	    redirect_to admin_user_path(@client)
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

	  def password_params
	    # NOTE: Using `strong_parameters` gem
	    params.require(:user).permit(:password, :password_confirmation)
	  end
  end
end
