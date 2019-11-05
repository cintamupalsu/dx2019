class AddKindToOperations < ActiveRecord::Migration[6.0]
  def change
    add_column :operations, :kind, :integer
  end
end
