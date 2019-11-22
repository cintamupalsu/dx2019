class CreateTaskdets < ActiveRecord::Migration[6.0]
  def change
    create_table :taskdets do |t|
      t.text :content
      t.integer :status
      t.references :user, null: false, foreign_key: true
      t.references :report, null: false, foreign_key: true

      t.timestamps
    end
  end
end
