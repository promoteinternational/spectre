class RemoveBaselineFromTests < ActiveRecord::Migration[5.0]
  def change
    remove_column :tests, :baseline, :boolean
  end
end
