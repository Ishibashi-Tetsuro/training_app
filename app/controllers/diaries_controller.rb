class DiariesController < ApplicationController

  def index
    @diaries = Diary.all
  end

  def show
    @diary = Diary.find(params[:id])
  end

  def new
    @diary = Diary.new
  end

  def create
    @diary = Diary.new(diary_params)
    if @diary.save
      redirect_to diaries_path
    else
      render :new
    end
  end

  def edit
    @diary = Diary.find(params[:id])
  end

  private

  def diary_params
    params.require(:diary).permit(:content, :image, :remove_image).merge(user_id: current_user.id)
  end

end
