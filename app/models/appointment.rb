class Appointment < ApplicationRecord
  belongs_to :patient, class_name: 'User', foreign_key: 'patient_id'
  belongs_to :doctor, class_name: 'User', foreign_key: 'doctor_id'
  enum status: [:pending, :accepted, :rejected, :cancelled]
  before_update :check_cancellation_time, if: :appointment_cancel
  before_save :scheduled_time_limit
  validates :patient_id, presence: true
  def appointment_cancel
    saved_changes.include?('cancellation_time')
  end

  def check_cancellation_time
    diff = scheduled_time - Time.now
    if (diff / 1.hour).round <= 1
      self.add(:base, 'Can be cancel before 1 hour')
      throw(:abort)
    end
  end

  def scheduled_time_limit
    diff = scheduled_time - Time.now
    if (diff / 1.hour).round < 5
      self.add(:base, 'Appointment can be scheduled before 5 hours')
      throw(:abort)
    end
  end
end
