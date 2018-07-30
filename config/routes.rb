Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  authenticated :user do
    root 'events#index', as: :authenticated_root
  end

  root to: 'pages#index'

  resources :events do
    resources :teams
    resources :teams_applications
    resources :shifts
    resources :requirements
    resources :availabilities
    resources :statistics, only: [:index]
    resources :schedules do
      collection do
        get :generate, to: 'schedules#generate'
        get :admin, to: 'schedules#admin'
      end
    end
  end


  namespace :admin do
    root 'users#index'
    resources :users, only: [:index]
  end

end
