Rails.application.routes.draw do
  devise_for :users
  resources :request_soft_auds
  resources :class_softwares
  resources :users
  resources :roles

  resources :faculties
  resources :cafedras
  resources :comp_classes
  resources :installed_softwares
  resources :request_softs

  root 'installed_softwares#index'
end
