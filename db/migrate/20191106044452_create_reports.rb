class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.references :vessel, null: false, foreign_key: true
      t.float :lat
      t.float :lon
      t.string :content

      t.timestamps
    end
    add_index :reports, [:vessel_id, :created_at]
  end
end
