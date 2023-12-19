class RenameWidthToSize < ActiveRecord::Migration[5.0]
  def change
    rename_column :tests, :width, :size
  end
end
