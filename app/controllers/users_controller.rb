class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @diaries = Diary.where(user_id: @user.id)
    @schedules = Schedule.where(user_id: @user.id).order(training_date: :asc)
    @exercises = Exercise.where(user_id: @user.id)
    @likes_count = Like.where(user_id: @user.id).count
    @count = Count.find_by(user_id: @user.id)

    if @count.nil?
      @count = Count.create(day: 0, user_id: @user.id)
    end

    # レベルアップの条件式
    if @count.day >= 15
      @level = 6
      @level_up_day = 0
    elsif @count.day >= 10
      @level = 5
      @level_up_day = 15 - @count.day
    elsif @count.day >= 6
      @level = 4
      @level_up_day = 10 - @count.day
    elsif @count.day >= 3
      @level = 3
      @level_up_day = 6 - @count.day
    elsif @count.day >= 1
      @level = 2
      @level_up_day = 3 - @count.day
    else
      @level = 1
      @level_up_day = 1 - @count.day
    end
    @character = Character.find(@level)
  end
end
