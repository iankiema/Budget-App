# config/routes.rb
Rails.application.routes.draw do

  authenticated :user do
    root "categories#index", as: :authenticated_root
  end

  unauthenticated do
    root "pages#splash", as: :unauthenticated_root
  end

  devise_for :users

  resources :categories do
    resources :expenditures, only: [:index, :new, :create, :destroy]
  end
end
