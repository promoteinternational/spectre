class RemoveRunsSequenceFromSuites < ActiveRecord::Migration[5.0]
  def change
    remove_column :suites, :runs_sequence, :integer
  end
end
