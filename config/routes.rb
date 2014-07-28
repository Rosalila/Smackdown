Myapp::Application.routes.draw do
  resources :smackdown_rules

  resources :smackdowns

  resources :player_rules

  resources :rules

  resources :rule_groups

  resources :user_playing_games

  resources :games

  get "home/index"
  get '/home/visit/:id', to: 'home#visit', as: 'visit'
#  post '/home/send_smackdown', to: 'home#send_smackdown', as: 'send_smackdown'
  get '/home/send_smackdown', to: 'home#send_smackdown', as: 'send_smackdown'
  get '/home/respond_smackdown', to: 'home#respond_smackdown', as: 'respond_smackdown'
  get '/home/judge1_smackdown', to: 'home#judge1_smackdown', as: 'judge1_smackdown'
  get '/home/judge2_smackdown', to: 'home#judge2_smackdown', as: 'judge2_smackdown'
  get '/home/respond_smackdown_list', to: 'home#respond_smackdown_list', as: 'respond_smackdown_list'
  get '/home/judge_smackdown_list', to: 'home#judge_smackdown_list', as: 'judge_smackdown_list'
  get '/home/users', to: 'home#users', as: 'users'
  get '/home/sent_smackdowns', to: 'home#sent_smackdowns', as: 'sent_smackdowns'
  get '/home/received_smackdowns', to: 'home#received_smackdowns', as: 'received_smackdowns'
  get '/home/judged_smackdowns', to: 'home#judged_smackdowns', as: 'judged_smackdowns'
  get '/home/profile', to: 'home#profile', as: 'profile'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
root to: 'home#index'

  #facebook
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]

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
