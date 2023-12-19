class ChangeDragonflyFields < ActiveRecord::Migration[5.0]
  def change
    remove_column :runs, :screenshot_uid, :string
    remove_column :runs, :screenshot_baseline_uid, :string
    remove_column :runs, :screenshot_diff_uid, :string

    add_column :tests, :screenshot_uid, :string
    add_column :tests, :screenshot_baseline_uid, :string
    add_column :tests, :screenshot_diff_uid, :string
  end
end
