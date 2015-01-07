Rails.application.routes.draw do
  root 'home#index'
  resources :sessions, only:[:new,:create,:destroy]
  mount CommunityHealthApi::API => '/'
  resources :doctors do

  end
  resources :members do
    post 'send_msg_doc', :on => :collection
  end
  match '/list_doctor_members',   to: 'doctors#list_members',   via: 'get'
  match '/members/bundling_doctor/:doctor_id', to: 'members#bundling_doctor', via:'get'
  match '/members/get_new_msg_num/:time', to: 'members#get_new_msg_num', via:'get'
  match '/health/adjust_month_chart/:member_id&:tyle',to: 'members#adjust_month_chart',via: 'get'
end
