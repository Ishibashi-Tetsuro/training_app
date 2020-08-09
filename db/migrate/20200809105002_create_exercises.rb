class CreateExercises < ActiveRecord::Migration[6.0]
  def change
    create_table :exercises do |t|
      t.string :part
      t.text :url
      t.integer :level
      t.timestamps
    end
  end
end
