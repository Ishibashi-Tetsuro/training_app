class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    @user = User.find(params[:id])
    @diaries = Diary.where(user_id: @user.id)
    @schedules = Schedule.where(user_id: @user.id).order(training_date: :asc)
    @exercises = Exercise.where(user_id: @user.id)
  end
end
