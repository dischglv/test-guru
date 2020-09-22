class CreateBadges < ActiveRecord::Migration[6.0]
  def change
    create_table :badges, primary_key: 'badge_id' do |t|
      t.string :name, null: false
      t.string :img_url, null: false
      t.string :rule, null: false

      t.references :category, null: true
      t.integer :level, null: true

      t.timestamps
    end
  end
end
