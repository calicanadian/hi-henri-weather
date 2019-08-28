Rails.application.routes.draw do
  root 'weathers#index', as: 'root'

  resources :sessions, only: [:create]
  resources :registrations, only: [:create]
  delete :logout, to: 'sessions#logout'
  get :logged_in, to: 'sessions#logged_in'
  get 'sign_out', to: 'sessions#sign_out'

  post :get_weather, to: 'weathers#get_weather'
  post :refresh_weather, to: 'weathers#refresh_weather'


  resources :users, only: [:show, :update] do
    collection do
      get :start
      get :signin
    end
    resources :locations, only: [:show, :index, :create, :edit, :destroy]
  end

  post :saved_location, to: 'user_locations#create', as: 'saved_locations'
  delete :saved_location, to: 'user_locations#destroy', as: 'saved_location'
end
