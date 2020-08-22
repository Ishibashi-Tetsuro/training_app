class DiariesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @diaries = Diary.all
  end

  def show
    @diary = Diary.find(params[:id])
    @like = Like.new
  end

  def new
    @diary = Diary.new
  end

  def create
    @diary = Diary.new(diary_params)
    if @diary.save
      flash[:notice] = '投稿が完了しました'
      redirect_to diaries_path
    else
      flash.now[:alert] = '入力を確認して下さい'
      render :new
    end
  end

  def edit
    @diary = Diary.find(params[:id])
  end

  def update
    @diary = Diary.find(params[:id])
    if @diary.update(diary_params)
      flash[:notice] = '編集が完了しました'
      redirect_to diaries_path
    else
      flash.now[:alert] = '画像の形式が不正な形式です'
      render :edit
    end

  end

  private

  def diary_params
    params.require(:diary).permit(:content, :image).merge(user_id: current_user.id)
  end

  def correct_user
    diary = Diary.find(params[:id])
    redirect_to root_url unless current_user.id == diary.user_id
  end

end
