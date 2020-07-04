Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
    	resources :appointments
    	put '/update_status/:appointment_id', to: 'appointments#update_status'
    	put '/cancel_appointment/:appointment_id', to: 'appointments#cancel_appointment'
    	resources :doctors
    	get '/accepted_appointments', to: 'doctors#accepted_appointments'
    	get '/rejected_appointments', to: 'doctors#rejected_appointments'
    end
	end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
