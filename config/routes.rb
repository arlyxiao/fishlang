Fishlang::Application.routes.draw do
  devise_for :users

  get "home/index"

  resources :lessons

  resources :practices do
    collection do
      get :exam
    end
  end

  resources :sentences do
    member do
      post :check
      get :continue
    end

  end


  namespace :admin do

    resources :lessons, :shallow => true do

      resources :practices, :shallow => true do
        resources :sentences, :shallow => true do
          resources :sentence_translations
        end
      end

    end

  end


  root :to => 'lessons#index'
end
