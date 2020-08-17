Rails.application.routes.draw do
  root 'articles#index'
  resources :articles
  resources :articles do
    resources :comments
  end
  resources :tags
end
