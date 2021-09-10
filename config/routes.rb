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
    resources :elements_payments, only: :new
    resources :elements, only: [:new, :create]
    resources :pay_now, only: [:create]
  end
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :orders, only: [ :show ]
    end
  end
  put "/update_quantity", to: "carts#update"
  delete "/delete_product", to: "carts#delete"
  mount StripeEvent::Engine, at: '/webhook'
  get "orders/:id/elements/elements_redirect", to: "elements#redirect"
end
