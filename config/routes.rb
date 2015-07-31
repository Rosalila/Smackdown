Myapp::Application.routes.draw do
  get '/dojos/manage_users', to: 'dojos#manage_users', as: 'dojo_manage_users'
  get '/dojos/accept_invitation', to: 'dojos#accept_invitation', as: 'dojo_accept_invitation'
  get '/dojos/decline_invitation', to: 'dojos#decline_invitation', as: 'dojo_decline_invitation'
  get '/communities/manage_users', to: 'communities#manage_users', as: 'community_manage_users'

  resources :user_in_communities

  resources :community_points

  resources :communities

  resources :dojo_invitations

  resources :user_in_dojos

  resources :favorites

  resources :dojos

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
  get '/home/judge_smackdown', to: 'home#judge_smackdown', as: 'judge_smackdown'
  get '/home/judge1_smackdown', to: 'home#judge1_smackdown', as: 'judge1_smackdown'
  get '/home/judge2_smackdown', to: 'home#judge2_smackdown', as: 'judge2_smackdown'
  get '/home/explore', to: 'home#explore', as: 'explore'
  get '/home/respond_smackdown_page/:smackdown_id', to: 'home#respond_smackdown_page', as: 'respond_smackdown_page'
  get '/home/judge_smackdown_page/:smackdown_id', to: 'home#judge_smackdown_page', as: 'judge_smackdown_page'
  get '/home/waiting_opponent_page/:smackdown_id', to: 'home#waiting_opponent_page', as: 'waiting_opponent_page'
  get '/home/waiting_judge_page/:smackdown_id', to: 'home#waiting_judge_page', as: 'waiting_judge_page'

  #Pending
  get '/home/pending_respond_smackdowns', to: 'home#pending_respond_smackdowns', as: 'pending_respond_smackdowns'
  get '/home/pending_judge_smackdowns', to: 'home#pending_judge_smackdowns', as: 'pending_judge_smackdowns'

  #History
  get '/home/history_sent_smackdowns', to: 'home#history_sent_smackdowns', as: 'history_sent_smackdowns'
  get '/home/history_received_smackdowns', to: 'home#history_received_smackdowns', as: 'history_received_smackdowns'
  get '/home/history_judged_smackdowns', to: 'home#history_judged_smackdowns', as: 'history_judged_smackdowns'

  #Smackdown creator
  get '/smackdown_creator/select_user', to: 'smackdown_creator#select_user', as: 'select_user'
  get '/smackdown_creator/select_game', to: 'smackdown_creator#select_game', as: 'select_games'
  get '/smackdown_creator/select_judge', to: 'smackdown_creator#select_judge', as: 'select_judge'
  get '/smackdown_creator/select_rules', to: 'smackdown_creator#select_rules', as: 'select_rules'

  #Response creator
  get '/response_creator/select_accept', to: 'response_creator#select_accept', as: 'response_select_accept'
  get '/response_creator/select_judge', to: 'response_creator#select_judge', as: 'response_select_judge'

  #Judge creator
  get '/judge_creator/select_accept', to: 'judge_creator#select_accept', as: 'select_accept'
  get '/judge_creator/select_winner', to: 'judge_creator#select_winner', as: 'select_winner'
  get '/judge_creator/select_comment', to: 'judge_creator#select_comment', as: 'select_comment'

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
  root to: 'home#explore'

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
