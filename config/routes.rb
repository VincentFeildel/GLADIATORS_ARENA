Rails.application.routes.draw do

  root to: 'pages#home'
  resources :fighters, only: [ :new, :create ]
  resources :fights, only: [ :show ]
  get 'fighting' => 'fights#fighting'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
