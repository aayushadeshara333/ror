Rails.application.routes.draw do
  root "books#index"
  # get 'books/:id', to: "books#show"
  resources :books
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
