class ExercisesController < ApplicationController
  before_action :authenticate_user!, only: [:show, :new, :create]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
  end

  def show
    @count = Count.find_by(user_id: current_user.id)
    @schedules = Schedule.where(user_id: current_user.id, training_date: Date.today)
    if @schedules.empty?
      @today_exercise = []
    elsif @schedules[0][:shape] == "不調"
      @today_exercise = Exercise.where(part: @schedules[0][:part],level: 1, user_id: current_user.id).order("RAND()").limit(1)
    else
      @today_exercise = Exercise.where(
                          part: @schedules[0][:part],level: 3, user_id: current_user.id).
                      or(Exercise.where(
                          part: @schedules[0][:part],level: 2, user_id: current_user.id )).
                      order("RAND()").limit(1)
    end
  end

  def new
    @exercise = Exercise.new
  end

  def create
    @exercise = Exercise.new(exercise_params)
    if @exercise.save
      flash[:notice] = '保存が完了しました'
      redirect_to exercise_path(current_user.id)
    else
      render :new
    end
  end

  private

  def exercise_params
    params.require(:exercise).permit(:url, :part, :level).merge(user_id: current_user.id)
  end

  def correct_user
    exercise = Exercise.find(params[:id])
    redirect_to root_url unless current_user.id == exercise.user_id
  end
end
