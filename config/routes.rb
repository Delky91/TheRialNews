Rails.application.routes.draw do
  resources :posts do
    resources :comments
  end
  devise_for :users, controllers: { registrations: 'users/registrations' }

  root 'posts#index'
end
