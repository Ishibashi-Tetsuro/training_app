class SchedulesController < ApplicationController

  def new
    @schedule = Form::ScheduleCollection.new
  end

  def create
    @schedule = Form::ScheduleCollection.new(schedule_collection_params)
    if @schedule.save
      redirect_to user_path(current_user.id)
    else
      render :new
    end
  end

  private

  def schedule_collection_params
    params
      .require(:form_schedule_collection)
      .permit(schedules_attributes: Form::Schedule::REGISTRABLE_ATTRIBUTES)
  end

end
