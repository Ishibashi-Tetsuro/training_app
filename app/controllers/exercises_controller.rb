class ExercisesController < ApplicationController

  def index
  end

  def show
    @exercise = Exercise.find(1)
  end

end
