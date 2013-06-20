Fishlang::Application.routes.draw do
  get "home/index"
  resources :sentences

  root :to => 'home#index'
end
