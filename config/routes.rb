Rails.application.routes.draw do
  root to: 'quotations#new'
  resources :quotations, only: [:new, :create]
  post "/create_transaction", to: "quotations#create_transaction"
  post "/create_callback", to: "quotations#create_callback"
  post "/create_card_info", to: "quotations#create_card_info"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
