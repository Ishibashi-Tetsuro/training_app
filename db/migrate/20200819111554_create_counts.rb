class CreateCounts < ActiveRecord::Migration[6.0]
  def change
    create_table :counts do |t|
      t.integer :day
      t.references :user, foreingn_key: true

      t.timestamps
    end
  end
end
