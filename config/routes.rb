Rails.application.routes.draw do
  scope '/api' do
    resources :categories, only: [:create, :index, :show]
    resources :companies, only: [:create, :index, :show]
    resources :users, only: [:index, :create, :show, :update, :destroy]
    resources :services, only: [:create, :index, :show, :update, :index]
  end
end
