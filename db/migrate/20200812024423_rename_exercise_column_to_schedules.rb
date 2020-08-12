class RenameExerciseColumnToSchedules < ActiveRecord::Migration[6.0]
  def change
    rename_column :schedules, :exercise, :exercise_id
  end
end
