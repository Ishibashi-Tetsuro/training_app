class ExercisesController < ApplicationController

  def index
  end

  def show
    @schedules = Schedule.where(user_id: current_user.id, training_date: Date.today)
  end

end
