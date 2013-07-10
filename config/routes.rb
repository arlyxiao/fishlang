Fishlang::Application.routes.draw do
  devise_for :users

  get "home/index"

  devise_for :users

  resources :lessons

  resources :practices do
    collection do
      get :exam
    end

    member do
      get :done
    end
  end

  resources :sentences do
    member do
      post :check
      get :continue
      post :report
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

    resources :sentence_reports

  end


  root :to => 'lessons#index'
end
