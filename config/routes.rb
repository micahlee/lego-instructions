Rails.application.routes.draw do
  devise_for :users
  get 'welcome/index'

  resources :lego_sets do
    collection do
      get 'cards'
    end

    member do
      get 'card'
    end
  end

  namespace :rebrickable do
    get 'search', to: 'api#search'
  end

  root 'welcome#index'
end
