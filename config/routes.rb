Rails.application.routes.draw do

  get 'articles/index'
  get 'articles/new', to: 'articles#new' 

  resources :articles

  root 'articles#index'
end
