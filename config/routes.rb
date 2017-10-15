Rails.application.routes.draw do

  get 'fights/show'

  root to: 'pages#home'
  resources :fighters
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
