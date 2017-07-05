Rails.application.routes.draw do

  resources :tasks do

    collection do
      delete 'destroy_multiple'
      get 'sort_by_title'
      get 'sort_by_date'
    end

    member do
      get 'progress'
      get 'open'
      get 'blocked'
      get 'closed'
    end

  end

  devise_for :users
  # devise_for :users, controllers: { sessions: 'users/sessions'}

  root "tasks#index"
end