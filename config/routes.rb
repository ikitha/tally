Rails.application.routes.draw do

  devise_for :admins
  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :transactions

	namespace :api, path: 'api/' do
   resources :search_suggestions, :users, :pacs
   resources :pols, :events do
    post '/comments' => 'comments#create', as: 'comments'
    post '/favorites' => 'favorites#create', as: 'favorites'
    delete '/favorites/:id' => 'favorites#destroy', as: 'remove_favorites'
   end
  end
 root to: "events#index"

 resources :events do
  post '/comments' => 'comments#create', as: 'comments'
  post '/favorites' => 'favorites#create', as: 'favorites'
  delete '/favorites/:id' => 'favorites#destroy', as: 'remove_favorites'
 end

 resources :search_suggestions, except: [:new, :edit]

 resources :users, except: [:new, :edit]

 resources :pacs do
  collection do
    get "confirm" => "pacs#confirm"
  end
 end

 resources :pols do
  post '/comments' => 'comments#create', as: 'comments'
  post '/favorites' => 'favorites#create', as: 'favorites'
  delete '/favorites/:id' => 'favorites#destroy', as: 'remove_favorites'
 end


 post '/api/users/signup' => 'api/users#create'

 post '/api/users/login' => 'api/users#attempt_login'

 post '/api/support' => 'api/voting#support'

 post '/api/oppose' => 'api/voting#oppose'
end
