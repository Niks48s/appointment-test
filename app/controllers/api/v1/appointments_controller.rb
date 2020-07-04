class Api::V1::AppointmentsController < ApplicationController
  before_action :authenticate_user!

  def index
    begin
      if current_user&.role&.eql?('doctor')
        appointments = Appointment.where('(doctor_id = ? and status = ?) or status != ?',
          current_user.id, Appointment.statuses['accepted'], Appointment.statuses['accepted'])
      elsif current_user&.role&.eql?('admin')
        appointments = Appointment.all
      else
        appointments = Appointment.where(patient_id: current_user.id)
      end
      appointment_list = AppointmentSerializer.new(appointments)
      render json: {
        data: appointment_list.serializable_hash[:data].map{|data| data[:attributes]}
      }
    rescue Exception => e
      render json: {
        status: {code: 400, message: e},
      }
    end
  end

  def create
    begin
      if current_user&.role&.eql?('patient')
        appointment = Appointment.new(appointment_params)
        if appointment.save
          render json: {
            status: {code: 200, message: 'Appointment created successfully.'},
            data: AppointmentSerializer.new(appointment).serializable_hash[:data][:attributes]
          }
        else
          raise(appointment.errors.full_messages.join(', '))
        end
      else
        raise('Only patient can book the appointment.')
      end
    rescue Exception => e
      render json: {
        status: {code: 400, message: e},
      }
    end
  end

  def update_status
    begin
      if current_user&.role&.eql?('doctor')
        appointment = Appointment.find_by(id: params[:appointment_id], doctor_id: current_user.id)
        if appointment.present? && appointment.update(status: params[:status])
          render json: {
            status: {code: 200, message: 'Appointment status updated successfully.'},
            data: AppointmentSerializer.new(appointment).serializable_hash[:data][:attributes]
          }
        else
          raise('Unable to update appointment.')
        end
      else
        raise('Only doctor can update appointment status.')
      end
    rescue Exception => e
      render json: {
        status: {code: 400, message: e},
      }
    end
  end

  def cancel_appointment
    begin
      if current_user&.role&.eql?('doctor')
        appointment = Appointment.find_by(id: params[:appointment_id], doctor_id: current_user.id)
        if appointment.present? && appointment.update(status: 'cancelled', is_cancelled: true, cancellation_time: Time.now)
          render json: {
            status: {code: 200, message: 'Appointment status updated successfully.'},
            data: AppointmentSerializer.new(appointment).serializable_hash[:data][:attributes]
          }
        else
          raise('Unable to update appointment.')
        end
      else
        raise('Only doctor can update appointment status.')
      end
    rescue Exception => e
      render json: {
        status: {code: 400, message: e},
      }
    end
  end


  private
  def appointment_params
    params[:appointment][:patient_id] = current_user&.id
    params.require(:appointment).permit(
      :patient_id, :doctor_id, :scheduled_time,
      :is_cancelled, :cancellation_time, :status,
      :notification_send 
    )
  end
end
