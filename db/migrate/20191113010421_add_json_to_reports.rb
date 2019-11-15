class AddJsonToReports < ActiveRecord::Migration[6.0]
  def change
    add_column :reports, :json, :string
  end
end
