Rails.application.routes.draw do
  # mount ActionCable.server, at: '/cable' REMOVEME?

  root to: 'matches#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :matches, only: [:index] do
    resource :prediction, only: [:new, :create], module: :matches
  end
end
