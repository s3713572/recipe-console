Rails.application.routes.draw do
  root to: 'recipes#index'

  resources :recipes
  resources :foods
  resources :purchase_orders
  get '/purchase_orders/:id/print_order', to: 'purchase_orders#print_order', as: 'print_order'
  get '/enter_form', to: 'recipes#enter_form'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
