class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    @user = User.find(params[:id])
    @diaries = @user.diaries
    @schedules = Schedule.where(user_id: current_user.id).order(training_date: :asc)
    @exercises = Exercise.where(user_id: current_user.id)
  end
end
