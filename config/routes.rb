Rails.application.routes.draw do
  
  get 'reset-password' => 'session#create_new_password'
  patch 'reset-password' => 'session#save_new_password', as: 'save_password'
  
  post 'resend_reg_code' => 'session#resend_reg_code'
  post 'password_recovery_request' => 'session#password_recovery_request'
  
  get 'register' => 'session#register', as: 'register'
  #post 'check_email' => 'session#check_email'
  patch 'create_account' => 'session#create_account'
  
  post 'attempt_login' => 'session#attempt_login'
  get 'login' => 'session#show_login'
  
  post 'signup' => 'page#signup'
  
  root 'page#index'
  
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
