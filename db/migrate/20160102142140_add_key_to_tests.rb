class AddKeyToTests < ActiveRecord::Migration[5.0]
  def change
    add_column :tests, :key, :string
  end
end
