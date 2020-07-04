class AppointmentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :scheduled_time, :is_cancelled, :cancellation_time, :status,
    :notification_send
  attribute :patient do |appointment|
  	UserSerializer.new(appointment.patient).serializable_hash[:data][:attributes]
  end
  attribute :doctor do |appointment|
  	UserSerializer.new(appointment.doctor).serializable_hash[:data][:attributes]
  end
end
