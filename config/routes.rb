Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  authenticated :user do
    root 'events#index', as: :authenticated_root
  end

  root to: 'pages#index'

  resources :events

  get 'events/:id/teams' => 'teams#index', as: 'teams'
  get 'events/:id/teams/new' => 'teams#new', as: 'new_team'
  post 'events/:id/teams' => 'teams#create'

end
