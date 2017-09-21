class AddAllDayToSchedules < ActiveRecord::Migration[5.1]
  def change
  	add_column :schedules, :all_day, :boolean
  end
end
