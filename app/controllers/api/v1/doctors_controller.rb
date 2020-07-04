class Api::V1::DoctorsController < ApplicationController
  before_action :authenticate_user!
  def index
    doctors = User.where(role: 'doctor')
    doctor_list = UserSerializer.new(doctors)
    render json: {
      data: doctor_list.serializable_hash[:data].map{|data| data[:attributes]}
    }
  end
  
  def accepted_appointments
    appointments = Appointment.where(doctor_id: current_user&.id, status: 'accepted')
    appointment_list = AppointmentSerializer.new(appointments)
    render json: {
      data: appointment_list.serializable_hash[:data].map{|data| data[:attributes]}
    }
  end

  def rejected_appointments
    appointments = Appointment.where(doctor_id: current_user&.id, status: 'rejected')
    appointment_list = AppointmentSerializer.new(appointments)
    render json: {
      data: appointment_list.serializable_hash[:data].map{|data| data[:attributes]}
    }
  end
end
