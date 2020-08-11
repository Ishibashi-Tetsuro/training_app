class SchedulesController < ApplicationController
  def new
    @schedule = Schedule.new
  end

  def create
    @schedule = Schedule.new(schedule_params)
    if @schedule.save
      redirect_to user_path(current_user.id)
    else
      render :new
    end
  end

  private

  def schedule_params
    params.require(:schedule).permit(:exercise, :training_date)
  end

end
