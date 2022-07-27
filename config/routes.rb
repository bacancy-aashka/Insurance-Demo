Rails.application.routes.draw do
  root to: 'quotations#new'
  resources :quotations, only: [:new, :create] do
    collection do
      post 'create_transaction'
      post 'create_callback'
      post 'create_card_info'
    end
  end
end