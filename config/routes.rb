Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  root 'products#index'
  resources :products, only: [:index, :show]
  resources :carts, only: [:new]
  resources :orders, only: [:show, :create] do
    resources :payments, only: :new
  end
  put "/update_quantity", to: "carts#update"
  delete "/delete_product", to: "carts#delete"
  mount StripeEvent::Engine, at: '/stripe-webhooks'
end
