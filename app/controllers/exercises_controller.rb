class ExercisesController < ApplicationController

  def index
  end

  def show
    @exercise = Exercise.new
    @schedules = Schedule.where(user_id: current_user.id, training_date: Date.today)
    if @schedules.empty?
      @today_exercise = []
    else
      @today_exercise = Exercise.where(part: @schedules[0][:part], user_id: current_user.id).order("RAND()").limit(1)
    end
  end

  def new
    @exercise = Exercise.new
  end

  def create
    @exercise = Exercise.new(exercise_params)
    @exercise.url = @exercise.url.last(11)
    if @exercise.save
      redirect_to exercise_path(current_user.id)
    else
      render :new
    end
  end

  private

  def exercise_params
    params.require(:exercise).permit(:url, :part, :level).merge(user_id: current_user.id)
  end

end
