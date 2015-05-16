class V1::StoriesController < ApplicationController

  def index
    stories = current_user.stories.order(created_at: :desc).all
    render json: stories, each_serializer: StorySerializer
  end

  def show
    story = current_user.stories.find(params[:id])
    render json: story, serializer: StorySerializer
  end

  def create
    story = current_user.stories.create!(story_params)
    render json: story, serializer: StorySerializer
  rescue => e
    render json: { error: t('story_controller.create_error') }, status: :unprocessable_entity
  end

  private

  def story_params
    params.require(:story).permit(:title, :body)
  end

end
