Rails.application.routes.draw do
  root 'home#index'
  resources :sessions, only:[:new,:create,:destroy]
  mount CommunityHealthApi::API => '/'
  resources :doctors do

  end
  resources :phy_exam_tpls do
    post 'save_items', :on => :collection
    delete 'destroy_multiple', :on => :collection
  end
  resources :members do
    post 'send_msg_doc', :on => :collection
  end
  resources :phy_exam_records
  match '/list_doctor_members',   to: 'doctors#list_members',   via: 'get'
  match '/members/bundling_doctor/:doctor_id', to: 'members#bundling_doctor', via:'get'
  match '/members/get_new_msg_num/:time&:member_id', to: 'members#get_new_msg_num', via:'get'
  match '/health/adjust_month_chart/:member_id&:tyle',to: 'members#adjust_month_chart',via: 'get'
  match '/phy_exam_tpls/destroy_item/:id', to: 'phy_exam_tpls#destroy_item', as: "destroy_item_exam_tpls",via: 'delete'
  match '/phy_exam_tpls/update_item/:id', to: 'phy_exam_tpls#update_item', as: "update_item_exam_tpls",via: 'put'
  match '/phy_exam_tpls/list_stand_result/:id', to: 'phy_exam_tpls#list_stand_result',via: 'get'
  match '/phy_exam_tpls/list_catagory_item/:id', to: 'phy_exam_tpls#list_catagory_item',via: 'get'
  match '/phy_exam_records/update_record/:id', to: 'phy_exam_records#update_record', as: "update_record_phy_exam",via: 'patch'
end
