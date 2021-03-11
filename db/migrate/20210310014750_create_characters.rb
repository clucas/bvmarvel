class CreateCharacters < ActiveRecord::Migration[6.1]
  def change
    create_table :characters do |t|
      t.string :name, null: false
      t.string :marvel_uuid, null: false
      t.text :description
      t.string :picture_url, null: false

      t.timestamps
    end
    add_index :characters, :name, unique: true
    add_index :characters, :marvel_uuid, unique: true
  end
end
