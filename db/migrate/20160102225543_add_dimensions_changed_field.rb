class AddDimensionsChangedField < ActiveRecord::Migration[5.0]
  def change
    add_column :tests, :dimensions_changed, :boolean
  end
end
