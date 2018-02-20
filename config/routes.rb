Rails.application.routes.draw do
  mount ActionCable.server, at: '/cable'

  # devise
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }
  # after_sign_out_path_for to: :login
  # after_sign_in_path_for to: 'matches#index' ???
  #
  root to: 'matches#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :matches, only: [:index] do
    resource :prediction, only: [:new, :create], module: :matches
  end
end
