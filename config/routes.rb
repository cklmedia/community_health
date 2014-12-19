Rails.application.routes.draw do
  root 'home#index'
  resources :sessions, only:[:new,:create,:destroy]
  mount CommunityHealthApi::API => '/'
  resources :doctors
  resources :members
  match '/members/bundling_doctor/:doctor_id', to: 'members#bundling_doctor', via:'get'

end
