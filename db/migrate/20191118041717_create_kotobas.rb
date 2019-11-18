class CreateKotobas < ActiveRecord::Migration[6.0]
  def change
    create_table :kotobas do |t|
      t.string :word
      t.string :message

      t.timestamps
    end
  end
end
