Rails.application.routes.draw do


  # resources :tasks do
  #
  #   collection do
  #     delete 'destroy_multiple'
  #     get 'sort_by_title'
  #     get 'sort_by_date'
  #     get 'history'
  #   end
  #
  #   member do
  #     get 'progress'
  #     get 'open'
  #     get 'blocked'
  #     get 'closed'
  #   end
  #
  # end

  devise_for :users
  # devise_for :users, controllers: { sessions: 'users/sessions'}

  root "tasks#index"

  resources :tasks

  #Collection Routes
  delete 'tasks/destroy_multiple',to:"tasks#destroy_multiple",as: :destroy_multiple_tasks
  get 'tasks/sort_by_title',to:"tasks#sort_by_title",as: :sort_by_title_tasks
  get 'tasks/sort_by_date',to:"tasks#sort_by_date",as: :sort_by_date_tasks
  get 'tasks/history',to:"tasks#history",as: :history_tasks

  #Member Routes
  get 'tasks/:id/progress',to:"tasks#progress",as: :progress_task
  get 'tasks/:id/open',to:"tasks#open",as: :open_task
  get 'tasks/:id/blocked',to:"tasks#blocked",as: :blocked_task
  get 'tasks/:id/closed',to:"tasks#closed",as: :closed_task

end