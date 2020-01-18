Rails.application.routes.draw do
  resources :attachments
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
    get 'projects/view/:projectid' => 'projects#show', :on => :collection
    get 'projects/edit/:projectid' => 'users#edit_project', :on => :collection
    post 'projects/edit/:projectid' => 'projects#update', :on => :collection
    get 'projects/delete/:projectid' => 'projects#destroy', :on => :collection 
    get 'projects/attachments/:projectid' => 'projects#attachments', :on => :collection
    get 'projects/attachments/create/:projectid' => 'projects#upload_attachments', :on => :collection
    post 'projects/attachments/create/:projectid' => 'attachments#create', :on => :collection
    # post 'projects/create' => 'projects#create', :on => :collection

    # Users Routes
    get 'projects/:projectid/users' => 'projects#users', :on => :collection
    get 'projects/:projectid/user/add' => 'projects#add_user', :on => :collection
    post 'projects/:projectid/user/add' => 'projects#create_user', :on => :collection
    get 'projects/:projectid/user/edit/:projectuserid' => 'projects#edit_user', :on => :collection
    post 'projects/:projectid/user/edit/:projectuserid' => 'projects#update_user', :on => :collection
    get 'projects/:projectid/user/delete/:projectuserid' => 'projects#delete_user', :on => :collection

    # Thread Routes
    get 'projects/threads/:projectid' => 'projects#threads', :on => :collection
    get 'projects/thread/create/:projectid' => 'projects#add_thread', :on => :collection
    post 'projects/threads/create/:projectid' => 'project_threads#create', :on => :collection
    get 'projects/threads/update/:projectid/:thread_id' => 'projects#edit_thread', :on => :collection
    post 'projects/threads/update/:projectid/:thread_id' => 'project_threads#update', :on => :collection
    get 'projects/threads/delete/:thread_id' => 'project_threads#destroy', :on => :collection
  end

  resources :admin do
    get 'logout', :on => :collection
    get 'login', :on => :collection
    get 'dashboard', :on => :collection
    get 'users' => 'admin#users', :on => :collection
    get 'users/projects/:userid' => 'admin#projects', :on => :collection
    get 'users/set_admin/:userid' => 'admin#set_admin', :on => :collection
    get 'users/unset_admin/:userid' => 'admin#unset_admin', :on => :collection
    post 'login' => 'admin#submit_login', :on => :collection
  end
  root 'users#index', as: 'home'

  namespace 'api' do
    namespace 'v1' do
      resources :users
      resources :projects do
        post 'user/:projectid/update' => 'projects#update_user', :on => :collection
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end