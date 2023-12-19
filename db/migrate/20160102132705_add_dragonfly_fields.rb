class AddDragonflyFields < ActiveRecord::Migration[5.0]
  def change
    add_column :runs, :screenshot_uid, :string
    add_column :runs, :screenshot_baseline_uid, :string
    add_column :runs, :screenshot_diff_uid, :string
  end
end
