J0bD::Application.routes.draw do

  get 'employers/favoritelist' => 'employers#favoriteList'

  resources :github_repos
  resources :employees
  resources :stack_tags
  resources :dribbbles, only: [:create]
  resources :linkedins, only: [:create, :show]
  resources :favorites, only: [:create]

  # LinkedIn
  get 'auth/linkedin/callback', to: 'linkedins#create'

  # uncommect this after LinkedIn test
  # get 'auth/linkedin/callback', to: 'employers#create'
  resources :employers, except: [:create]
  delete '/employers' => 'employers#destroy'

  # Github
  get 'auth/:provider/callback', to: 'github_accounts#create'
  get 'auth/failure', to: redirect('/')
  delete 'signout', to: 'github_accounts#destroy', as: 'signout'

  resources :github_accounts, only: [:create, :destroy]

  get "employees/update"
  get "employees/new"
  get "page/landing_page"
  root 'page#landing_page'
  post 'employees/create' => 'employees#create'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"


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
