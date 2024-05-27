Rails.application.routes.draw do
  devise_for :users
  resources :collections do
    resources :items do
      resources :comments, only: [:create]
      resources :likes, only: [:create, :destroy]
    end
    # resources :dynamic_fields, only: [:create, :new]
  end
  # resources :comments

  resources :item_fields
  resources :item_field_values
  resources :item_tags
  # resources :likes, only: [:create, :destroy]
  resources :tags
  resources :users, only: [:update]
  root 'homes#index'
  get 'display_tags/:id', to: 'items#display_tags'
  get 'profile', to: 'users#profile'
  get 'admin_dashboard', to: 'users#admin_dashboard'
  get 'user_details/:id', to: 'users#user_details'
  post 'manage_user/:id', to: 'users#manage_user'
  delete 'delete_user/:id', to: 'users#delete_user'
  delete 'remove_dynamic_fields/:id', to: 'items#remove_dynamic_fields'
  get 'search', to: "search#index"
end
