class AddStatusToSchedules < ActiveRecord::Migration[5.1]
  def change
  	add_column :schedules, :status, :integer
  end
end
