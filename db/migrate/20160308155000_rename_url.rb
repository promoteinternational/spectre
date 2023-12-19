class RenameUrl < ActiveRecord::Migration[5.0]
  def change
    rename_column :tests, :url, :source_url
  end
end
