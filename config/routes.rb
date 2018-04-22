Rails.application.routes.draw do
  mount ActionCable.server, at: '/cable'

  resources :users, only: [:show], param: :player_id
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }

  resources :squads, except: [:index], param: :parameterized_name do
    resources :member_invitations, only: [:new, :create], module: :squads
    resources :accept_invitations, only: [:create]      , module: :squads
    resources :reject_invitations, only: [:create]      , module: :squads
  end

  get 'global_ranking'      , to: 'ranking#index'     , as: :ranking
  get 'prediction_center'   , to: 'matches#index'     , as: :prediction_center
  get 'deactivate/:token'   , to: 'deactivations#new' , as: :deactivate

  namespace :admin do
    resource :sessions
    resources :matches do
      resources :final_scores, only: [:new, :create], module: :matches
    end
    get 'sign_in', to: 'sessions#new', as: :sign_in
    root to: 'matches#index'
  end
  root to: 'users#show'
end
