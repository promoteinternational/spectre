class AddPassToTests < ActiveRecord::Migration[5.0]
  def change
    add_column :tests, :pass, :boolean
  end
end
