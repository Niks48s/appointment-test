class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
      :recoverable, :rememberable, :validatable,
      :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist
  has_many :doctor_appointments, class_name: 'Appointment', foreign_key: 'doctor_id' 
  has_many :patient_appointments, class_name: 'Appointment', foreign_key: 'patient_id' 
  enum role: [:patient, :doctor, :admin]
end
