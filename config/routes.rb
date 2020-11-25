Rails.application.routes.draw do
  root to: 'tops#index'
  get  '/' => 'tops#index'
  resources :app_tops, only: [:index]
  resources :properties, only:[:new, :create, :show] do
    member do
      get 'sort'
    end
  end
  resources :rooms, only:[:show] do
    member do
      get "new"
      post "create"
      get "resource"
    end
  end
  devise_for :companies, controllers: {
    sessions: 'companies/sessions',
    passwords: 'companies/passwords',
    registrations: 'companies/registrations'
  }
  devise_for :workers, controllers: {
    sessions: 'workers/sessions',
    passwords: 'workers/passwords',
    registrations: 'workers/registrations'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
