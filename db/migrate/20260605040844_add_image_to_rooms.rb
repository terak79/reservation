class AddImageToRooms < ActiveRecord::Migration[7.2]
  def change
    add_column :rooms, :image, :string
  end
end
