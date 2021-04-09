class CreateMemberShifts < ActiveRecord::Migration[5.2]
  def change
    create_table :member_shifts do |t|
      t.datetime :shift_date
      t.string :start_time
      t.string :end_time
      t.references :user, foreign_key: true
      t.references :team, foreign_key: true

      t.timestamps
    end
  end
end
