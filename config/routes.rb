Rails.application.routes.draw do
  resources :users do
    resources :projects
    get 'logout', :on => :collection
    get 'login', :on => :collection
    post 'login' => 'users#submit_login', :on => :collection
    get 'dashboard', :on => :collection
    get 'profile', :on => :collection
    patch 'profile' => 'users#submit_profile', :on => :collection
    get 'projects', :on => :collection
    get 'projects/create' => 'users#create_project', :on => :collection
    post 'projects/create' => 'projects#create', :on => :collection
    get 'projects/edit/:projectid' => 'users#edit_project', :on => :collection
    # post 'projects/create' => 'projects#create', :on => :collection
  end
  root 'users#index', as: 'home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
