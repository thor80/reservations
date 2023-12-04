class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :image
      t.string :name
      t.string :introduction
      t.integer :fee
      t.string :address
      t.string :prefecture
      t.string :postcode
      t.string :city
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
