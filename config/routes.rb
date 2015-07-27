Rails.application.routes.draw do

  devise_for :users

  root 'home#Index'
  match '/help',    to: 'static_pages#help',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  match '/index',   to: 'home#Index', via: 'get'
  get '/users', to: 'user#show', as: :user_show
  get '/user/index/:id', to: 'user#index', as: :user_index
  get '/user/edit/:id', to: 'user#edit', as: :user_edit
  post '/user/update/:id', to: 'user#update', as: :user_update
  delete '/user/destroy/:id', to: 'user#destroy', as: :user_destroy
  post '/user/update_password', to: 'user#update_password', as: :user_update_password
  get '/user/edit_password', to: 'user#edit_password', as: :user_change_password

  get '/tasks', to: 'task#show', as: :task_show
  get '/task/show/:id', to: 'task#show_task_user', as: :task_show_user
  get '/task/edit/:id', to: 'task#edit', as: :task_edit
  get '/task/add', to: 'task#add', as: :task_add
  post '/task/new', to: 'task#new', as: :task_new
  post '/task/update/:id', to: 'task#update', as: :task_update
  delete '/task/destroy/:id', to: 'task#destroy', as: :task_destroy
  post '/task/share/:id#:email', to: 'task#share' , as: :task_share

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
