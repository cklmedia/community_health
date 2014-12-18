Rails.application.routes.draw do
  root 'home#index'
  resources :sessions, only:[:new,:create,:destroy]
  mount CommunityHealthApi::API => '/'
  resources :doctors
  resources :members
end
