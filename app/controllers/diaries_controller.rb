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

  def update
    @diary = Diary.find(params[:id])
    if @diary.update!(diary_params)
      flash[:notice] = '編集が完了しました'
      redirect_to diaries_path
    else
      @diary = e.record
      flash.now[:alert] = '画像の形式が不正な形式です'
      render :edit
    end

  end

  private

  def diary_params
    params.require(:diary).permit(:content, :image).merge(user_id: current_user.id)
  end

end
