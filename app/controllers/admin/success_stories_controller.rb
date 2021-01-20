module Admin
  class SuccessStoriesController < BaseController

    def index
      @success_stories = SuccessStory.all
    end

    def approve
      @success_story = SuccessStory.find(params[:id])
      @success_story.update(approved: true)
      UserMailer.success_story_approved(@success_story.user).deliver_now
      flash[:success] = 'Request approved'
      redirect_to admin_success_stories_path
    end


    def edit
      @success_story = SuccessStory.find(params[:id])
    end

    def update
      @success_story = SuccessStory.find(params[:id])
      if @success_story.update(success_story_params)
        flash[:success] = 'Story Updated Successfully'
        redirect_to admin_success_stories_path
      else
        render :edit
      end
    end

    def destroy
      @success_story = SuccessStory.find(params[:id])
      @success_story.destroy
      flash[:success] = 'Story deleted successfully'
      redirect_to admin_success_stories_path
    end

    private

    def success_story_params
      params.require(:success_story).permit(:name, :description, :image)
    end
  end
end
