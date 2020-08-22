class SchedulesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :index, :edit, :update]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @schedule = Form::ScheduleCollection.new
  end

  def create
    @schedule = Form::ScheduleCollection.new(schedule_collection_params)
    if @schedule.save
      redirect_to user_path(current_user.id)
      flash[:notice] = 'スケジュールを記録しました'
    else
      flash.now[:alert] = '入力された値が間違っています'
      render :new
    end
  end

  def index
    @schedules = Schedule.where(user_id: current_user.id).order(training_date: :asc)
  end

  def edit
    @schedules = Schedule.where(user_id: current_user.id).order(training_date: :asc)
  end

  def update
    @schedule = Schedule.find(params[:id])
    if @schedule.update(schedule_params)
      flash[:notice] = '編集が完了しました'
      redirect_to schedules_path
    else
      flash.now[:alert] = '入力された値が間違っています'
      render :edit
    end
  end

  private

  def schedule_collection_params
    params
      .require(:form_schedule_collection)
      .permit(schedules_attributes: Form::Schedule::REGISTRABLE_ATTRIBUTES)
  end

  def schedule_params
    params.require(:schedule).permit(:training_date, :part, :work, :shape, :user_id)
  end

  def correct_user
    schedule = Schedule.find(params[:id])
    redirect_to root_url unless current_user.id == schedule.user_id
  end

end
