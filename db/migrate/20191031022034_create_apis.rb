class CreateApis < ActiveRecord::Migration[6.0]
  def change
    create_table :apis do |t|
      t.string :key
      t.references :user, null: false, foreign_key: true
      t.integer :status
      t.text :note

      t.timestamps
    end
  end
end
