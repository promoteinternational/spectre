class AddFuzzLevelToTests < ActiveRecord::Migration[5.0]
  def change
    add_column :tests, :fuzz_level, :string
  end
end
