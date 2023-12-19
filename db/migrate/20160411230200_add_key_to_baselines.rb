class AddKeyToBaselines < ActiveRecord::Migration[5.0]
  def change
    add_column :baselines, :key, :string
  end
end
