class AddUrlToTests < ActiveRecord::Migration[5.0]
  def change
    add_column :tests, :url, :string
  end
end
