class CreateScheduleParticipants < ActiveRecord::Migration[5.1]
  def change
    create_table :schedule_participants do |t|
      t.references :schedule, foreign_key: true
      t.integer :participant_id
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
