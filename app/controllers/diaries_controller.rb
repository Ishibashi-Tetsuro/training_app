class DiariesController < ApplicationController
  def index
    @diariys = Diary.all
  end

  def show
    @diary = Diary.find(params[:id])
  end

  def create
  end
end
