Rails.application.routes.draw do

  #static pages
  get 'home/index'
  get 'photos/feature_example'
  
  root :to => "photos#index"

  devise_for :users, controllers: { registrations: "registrations"}
  
  resources :profiles, except: :destroy do 
    resources :photos, controller: 'profiles/photos', only: [:index,:show,:new,:create]
  end

  resources :photos, except: [:edit, :update] do 
    resources :critiques, controller: 'photos/critiques'
  end
  
end

