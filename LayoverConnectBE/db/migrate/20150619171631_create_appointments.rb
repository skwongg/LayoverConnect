class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.integer :business_id
      t.integer :user_id
      t.boolean :attending
      t.datetime :start_time
      t.datetime :end_time
      t.timestamps null: false
    end
  end
end
