class SuccessStoriesController < ApplicationController

  def index
    @success_stories = current_user.success_stories
  end

  def edit
      @success_story = SuccessStory.find(params[:id])
    end

  def update
    @success_story = SuccessStory.find(params[:id])
    if @success_story.update(success_story_params)
      flash[:success] = 'Story Updated Successfully'
      redirect_to success_stories_path
    else
      render :edit
    end
  end

  def create
    story = current_user.success_stories.new(success_story_params)
    if story.save
    	flash[:success] = 'Your success story is sent to admin for review.'
      redirect_to root_path
    else
      render :new
    end
  end

  def new
  	@success_story = SuccessStory.new
  end

  private

  def success_story_params
    params.require(:success_story).permit(:name, :description, :image)
  end
end
