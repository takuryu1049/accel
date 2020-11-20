Rails.application.routes.draw do
  root to: 'tops#index'
  get  '/' => 'tops#index'
  resources :app_tops, only: [:index]
  resources :properties, only:[:new, :create, :index] do
    member do
      get 'sort'
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
