Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to => "document#index"
  resources :document, :except => [:edit, :put]

  get '/login' => 'session#new', as: :login
  post '/login' => 'session#create', as: :create_session
  delete '/logout' => 'session#destroy', as: :logout

  get '/signup' => 'user#new', as: :signup
  post '/signup' => 'user#create', as: :create_user

  get '/add_document' => 'document#new', as: :document_new
  post '/create_document' => 'document#create', as: :document_create

end
