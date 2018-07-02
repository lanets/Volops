Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  authenticated :user do
    root 'events#index', as: :authenticated_root
  end

  root to: 'pages#index'

  resources :events
  resources :events do
    resources :teams
    resources :teams_applications
  end

=begin
    get 'events/:id/teams' => 'teams#index', as: 'teams'
    get 'events/:id/teams/new' => 'teams#new', as: 'new_team'
    get 'events/:id/teams/:secondId' => 'teams#show', as: 'show_team'
    get 'events/:id/teams/apply', :to => 'teams_applications#new',
        as: 'new_teams_applications'
    post 'events/:id/teams' => 'teams#create'
    post 'events/:id/teams/apply' => 'teams_applications#create'
=end

end
