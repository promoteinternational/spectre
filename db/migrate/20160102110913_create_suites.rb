class CreateSuites < ActiveRecord::Migration[5.0]
  def change
    create_table :suites do |t|
      t.string :name
      t.references :project
      t.integer :runs_sequence

      t.timestamps null: false
    end
  end
end
