class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.integer :patient_id
      t.integer :doctor_id
      t.datetime :scheduled_time
      t.boolean :is_cancelled, default: false
      t.datetime :cancellation_time
      t.integer :status, default: 0
      t.boolean :notification_send, default: false

      t.timestamps
    end
  end
end
