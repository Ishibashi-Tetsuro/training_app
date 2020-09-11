class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(diary_id: params[:diary_id])
    @like.save
    # @like = current_user.likes.create(diary_id: params[:diary_id])
    # redirect_back(fallback_location: root_path)
    @diary = Diary.find(params[:diary_id])
    respond_to :js
  end

  def destroy
    @like = Like.find_by(diary_id: params[:diary_id], user_id: current_user.id)
    @like.destroy
    # redirect_back(fallback_location: root_path)
    @diary = Diary.find(params[:diary_id])
    respond_to :js
  end
end
