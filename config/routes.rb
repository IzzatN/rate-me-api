Rails.application.routes.draw do
  scope '/api' do
    resources :auth_sessions, only: [:create, :index]
    resources :categories, only: [:index, :show]
    resources :companies, only: [:create, :index, :show, :update]
    resources :users, only: [:index, :create, :show, :update, :destroy]
    resources :services, only: [:create, :index, :show, :update, :index]
    resources :comments, only: [:show, :index, :create, :destroy]
  end
end
