Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  root 'products#index'
  resources :products, only: [:index, :show]
  resources :cards, only: [:index, :destroy, :update]
  resources :carts, only: [:new]
  resources :orders, only: [:show, :create] do
    resources :payments, only: :new
    resources :elements_payments, only: :new
    resources :elements, only: [:new, :create]
    resources :pay_now, only: [:create]
    resources :checkout_currency, only: :new
  end
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :orders, only: [ :show ]
    end
  end
  put "/update_quantity", to: "carts#update"
  delete "/delete_product", to: "carts#delete"
  put "/change_currency", to: "elements_payments#change_currency"
  put "/checkout_change_currency", to: "checkout_currency#change_currency"
  mount StripeEvent::Engine, at: '/webhook'
  get "orders/:id/elements/elements_redirect", to: "elements#redirect"
end
