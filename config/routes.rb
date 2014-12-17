Rails.application.routes.draw do
  root 'home#index'

  mount CommunityHealthApi::API => '/'
  
end
