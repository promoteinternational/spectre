class RemovePlatform < ActiveRecord::Migration[5.0]
  def change
    remove_column :tests, :platform, :string
    remove_column :baselines, :platform, :string
  end
end
