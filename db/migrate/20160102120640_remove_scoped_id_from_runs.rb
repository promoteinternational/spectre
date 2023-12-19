class RemoveScopedIdFromRuns < ActiveRecord::Migration[5.0]
  def change
    remove_column :runs, :scoped_id, :integer
  end
end
