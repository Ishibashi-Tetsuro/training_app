class AddImageToDiaries < ActiveRecord::Migration[6.0]
  def change
    add_column :diaries, :image, :string
  end
end
