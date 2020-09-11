class DiariesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @diaries = Diary.all.order(id: "DESC")
  end

  def show
    @diary = Diary.find(params[:id])
    if like = Like.find_by(user_id: current_user.id, diary_id: params[:id])
      @like = like
    else
      @like = Like.new
    end
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
      flash.now[:alert] = '入力を確認してください'
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
      redirect_to diary_path(@diary)
    else
      flash.now[:alert] = '入力を確認してください'
      render :edit
    end
  end

  def destroy
    diary = Diary.find(params[:id])
    diary.destroy
    flash[:notice] = '１件の日記を削除しました'
    redirect_to diaries_path
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
