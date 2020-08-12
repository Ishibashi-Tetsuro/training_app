class RenameExerciseIdColumnToSchedules < ActiveRecord::Migration[6.0]
  def change
    rename_column :schedules, :exercise_id, :part
  end
end
