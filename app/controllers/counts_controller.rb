class CountsController < ApplicationController

  def create
    @count = Count.new(day: 0, user_id: current_user.id)
    if @count.save
      redirect_to exercises_path
    else
      render 'exercises/index'
    end
  end

  def update
    @count = Count.find_by(user_id: current_user.id)
    day = @count.day + 1
    if @count.update(day: day)
      redirect_to exercises_path
    else
      render 'exercises/index'
    end
  end

end
