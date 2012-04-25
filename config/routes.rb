RedisOnRails::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  resource :authentications
  match '/auth/failure' =>'authentications#failure'
  match '/auth/:provider/callback' =>'authentications#create'

  resources :attendees
  resources :conferences
  resource :notes
  resource :registrations

  root :to => 'conferences#index'

  # miscellaneous routes
  if Rails.env.development?
    # handle twilio ping when using localtunnel gem
    post '/callbacks', to: lambda { |env| [200, {"Content-Type" => "text/html"}, ["OK"]] }
  end

end
