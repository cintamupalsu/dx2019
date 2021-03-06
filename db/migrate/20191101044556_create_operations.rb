class CreateOperations < ActiveRecord::Migration[6.0]
  def change
    create_table :operations do |t|
      t.references :vessel, null: false, foreign_key: true
      t.string :address
      t.text :note

      t.timestamps
    end
  end
end
