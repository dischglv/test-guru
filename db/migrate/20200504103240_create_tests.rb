class CreateTests < ActiveRecord::Migration[6.0]
  def change
    create_table :tests do |t|
      t.string :title
      t.integer :level
      t.text :description
      t.integer :category_id
      t.integer :author_id

      t.timestamps
    end
  end
end
