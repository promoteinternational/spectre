class AddCropAreaToTest < ActiveRecord::Migration[5.0]
  def change
    add_column :tests, :crop_area, :string
  end
end
