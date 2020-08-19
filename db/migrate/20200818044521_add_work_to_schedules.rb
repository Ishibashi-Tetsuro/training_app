class AddWorkToSchedules < ActiveRecord::Migration[6.0]
  def change
    add_column :schedules, :work, :string
    add_column :schedules, :shape, :string
  end
end
