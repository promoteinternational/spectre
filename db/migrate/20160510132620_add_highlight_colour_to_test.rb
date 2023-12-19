class AddHighlightColourToTest < ActiveRecord::Migration[5.0]
  def change
    add_column :tests, :highlight_colour, :string
  end
end
