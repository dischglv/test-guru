class AddUrlToGists < ActiveRecord::Migration[6.0]
  def change
    add_column :gists, :url, :string
  end
end
