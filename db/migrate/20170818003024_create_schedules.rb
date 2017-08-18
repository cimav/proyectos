class CreateSchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :schedules do |t|
      t.string :title
      t.text :content
      t.references :project, foreign_key: true
      t.datetime :start_date
      t.datetime :end_date
      t.integer :schedule_type
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
