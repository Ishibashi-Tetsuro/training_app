class CreateSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :schedules do |t|
      t.string :exercise
      t.date :training_date
      t.timestamps
    end
  end
end
