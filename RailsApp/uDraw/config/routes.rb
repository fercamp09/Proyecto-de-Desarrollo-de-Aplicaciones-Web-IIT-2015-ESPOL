Rails.application.routes.draw do
  resources :users
  resources :diagrams
  get 'diagram/index'

  get 'diagram/new'

  post 'diagram/create'

  delete 'diagram/destroy'

  get 'login' => 'application#login'
  get 'index' => 'application#index'
  get 'register' => 'users#new'
  get 'window' => 'application#window'
  get 'workstation' => 'application#workstation'
  post 'share/:id' => 'diagrams#share'
  #get 'diagram/:id' => 'application#workstation'
  #get 'diagram/show/:id' => 'diagram#show'
  #get '/:id' => 'diagrams#show'
  get 'signin' => 'session#new'
  post 'signin' => 'session#create'
  delete 'logout' => 'session#destroy'

  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'application#index'

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
