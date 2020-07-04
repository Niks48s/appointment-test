class NotificationWorker
  include Sidekiq::Worker
  sidekiq_options retry: true

  def perform(appointment_id)
    appointment = Appointment.find_by(id: appointment_id)
    if appointment.present? && appointment.status.eql?('accepted')
      UserMailer.doctor_notification(appointment.doctor, appointment).deliver_now
      UserMailer.patient_notification(appointment.patient, appointment).deliver_now
      appointment.update(notification_send: true)
    end
  end
end