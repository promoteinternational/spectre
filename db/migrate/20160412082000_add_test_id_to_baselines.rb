class AddTestIdToBaselines < ActiveRecord::Migration[5.0]
  def change
    add_column :baselines, :test_id, :integer
  end
end
