class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'
  def doctor_notification(doctor, appoinment)
  	@doctor = doctor
  	@appoinment = appoinment
  	mail(to: @doctor.email, subject: 'Appoinment Notification.')
  end

  def patient_notification(patient, appoinment)
  	@patient = patient
  	@appoinment = appoinment
  	mail(to: @patient.email, subject: 'Appoinment Notification.')
  end
end
