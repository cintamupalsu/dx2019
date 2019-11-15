class CreateProgresses < ActiveRecord::Migration[6.0]
  def change
    create_table :progresses do |t|
      t.references :status, null: false, foreign_key: true
      t.text :content
      t.references :report, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :progresses, [:status_id, :created_at]
  end
end
