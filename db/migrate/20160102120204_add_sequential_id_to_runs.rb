class AddSequentialIdToRuns < ActiveRecord::Migration[5.0]
  def change
    add_column :runs, :sequential_id, :integer
  end
end
