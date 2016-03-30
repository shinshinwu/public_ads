Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root to: 'listings#home'
  get '/', to: 'listings#home'
  resources :listings do
    member do
      get 'payments',   to: 'listings#payments'
      get 'payment/new', to: 'listings#new_payment'
    end
  end

  resources :users, only: [:new, :create] do
    collection do
      get '/signup',    to: 'users#new'
      get '/login',     to: 'sessions#new'
      post '/login',    to: 'sessions#create'
      delete '/logout', to: 'sessions#destroy'
      get '/profile',   to: 'users#show'
      get '/edit',      to: 'users#edit'
      put '/edit',      to: 'users#update'
      get '/conversation', to: 'users#conversation'
    end
  end

  resources :inquiries, only: [:create] do
  end

  resources :transactions, only: [:create] do
  end

  get '/sandbox' => 'sandbox#index', as: :sandbox
end
