Rails.application.routes.draw do
  root 'weathers#index', as: 'root'

  resources :sessions, only: [:create]
  resources :registrations, only: [:create]
  delete :logout, to: 'sessions#logout'
  get :logged_in, to: 'sessions#logged_in'


  resources :users, only: [:show] do
    collection do
      get :start
    end
    resources :locations, only: [:show, :index, :create, :edit, :destroy]
  end

  resources :user_locations
end
