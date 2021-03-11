class CreateStories < ActiveRecord::Migration[6.1]
  def change
    create_table :stories do |t|
      t.string :title
      t.string :marvel_uuid
      t.text :description

      t.timestamps
    end
    add_index :stories, :marvel_uuid, unique: true
  end
end
