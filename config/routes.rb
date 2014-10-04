Myapp::Application.routes.draw do
  resources :feedbacks

  resources :meta_images

  resources :smackdown_rules

  resources :smackdowns

  resources :player_rules

  resources :rules

  resources :rule_groups

  resources :user_playing_games

  resources :games

  get "home/index"
  get '/home/visit/:id', to: 'home#visit', as: 'visit'
  get '/home/send_smackdown', to: 'home#send_smackdown', as: 'send_smackdown'
  get '/home/respond_smackdown', to: 'home#respond_smackdown', as: 'respond_smackdown'
  get '/home/judge1_smackdown', to: 'home#judge1_smackdown', as: 'judge1_smackdown'
  get '/home/judge2_smackdown', to: 'home#judge2_smackdown', as: 'judge2_smackdown'
  get '/home/users', to: 'home#users', as: 'users'

  #Pending
  get '/home/pending_respond_smackdown', to: 'home#pending_respond_smackdown', as: 'pending_respond_smackdown'
  get '/home/pending_judge_smackdown', to: 'home#pending_judge_smackdown', as: 'pending_judge_smackdown'

  #History
  get '/home/history_sent_smackdowns', to: 'home#history_sent_smackdowns', as: 'history_sent_smackdowns'
  get '/home/history_received_smackdowns', to: 'home#history_received_smackdowns', as: 'history_received_smackdowns'
  get '/home/history_judged_smackdowns', to: 'home#history_judged_smackdowns', as: 'history_judged_smackdowns'

  #Smackdown creator
  get '/smackdown_creator/select_user', to: 'smackdown_creator#select_user', as: 'select_user'
  get '/smackdown_creator/select_game', to: 'smackdown_creator#select_game', as: 'select_games'
  get '/smackdown_creator/select_rules', to: 'smackdown_creator#select_rules', as: 'select_rules'

  #Shareables
  get '/shareables/versus/:id1/:id2/:meta_image', to: 'shareables#versus', as: 'shareable_versus'
  get '/shareables/smackdown/:id/:meta_image', to: 'shareables#smackdown', as: 'shareable_smackdown'

  get '/home/profile', to: 'home#profile', as: 'profile'
  get '/home/wating_opponent', to: 'home#wating_opponent', as: 'wating_opponent'
  get '/home/wating_judges', to: 'home#wating_judges', as: 'wating_judges'
  get '/home/ajax_test', to: 'home#ajax_test', as: 'ajax_test'
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
