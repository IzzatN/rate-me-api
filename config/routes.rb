Rails.application.routes.draw do
  scope '/api' do
    resources :categories, only: [:index]
    resources :companies, only: [:create, :index, :show, :update]
    resources :users, only: [:index, :create, :show, :update, :destroy]
    resources :services, only: [:create, :index, :show, :update, :index]
  end
end
