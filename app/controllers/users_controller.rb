class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @diaries = @user.diaries
    @schedules = Schedule.where(user_id: current_user.id).order(training_date: :asc)
  end
end
