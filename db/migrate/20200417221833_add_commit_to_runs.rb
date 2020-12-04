class AddCommitToRuns < ActiveRecord::Migration[5.0]
  def change
    add_column :runs, :commit, :string
  end
end
