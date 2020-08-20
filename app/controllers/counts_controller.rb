class CountsController < ApplicationController

  def show
    @count = Count.find_by(user_id: current_user.id)
    if @count.day >= 15
      level = 6
      @level_up_day = 0
    elsif @count.day >= 10
      level = 5
      @level_up_day = 15 - @count.day
    elsif @count.day >= 6
      level = 4
      @level_up_day = 10 - @count.day
    elsif @count.day >= 3
      level = 3
      @level_up_day = 6 - @count.day
    elsif @count.day >= 1
      level = 2
      @level_up_day = 3 - @count.day
    else
      level = 1
      @level_up_day = 1 - @count.day
    end
    @count.day
    @character = Character.find(level)
    @diary = Diary.new
  end

  def create
    @count = Count.new(day: 0, user_id: current_user.id)
    if @count.save
      flash[:notice] = "本日のエサを与えました"
      redirect_to count_path(@count)
    else
      flash[:alert] = "エラーが発生しました。しばらく立ってから再度アクセスして下さい"
      render 'exercises/index'
    end
  end

  def update
    @count = Count.find_by(user_id: current_user.id)
    day = @count.day + 1
    update = @count.updated_at
    if update.day == Date.today.day && update.month == Date.today.month
      flash[:notice] = "1日に与えられるエサは1つまでです"
      redirect_to count_path(@count)
    elsif @count.update(day: day)
      flash[:notice] = "本日のエサを与えました"
      redirect_to count_path(@count)
    else
      flash[:alert] = "エラーが発生しました。しばらく立ってから再度アクセスして下さい"
      render 'exercises/show'
    end
  end

end
