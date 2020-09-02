Rails.application.routes.draw do
  devise_for :users, :path => 'accounts' 
  
    
    resources :users, :path => 'u', only: [:index, :show] do
      resources :master_decks, :path => 'decks', only: [:index, :show] do
        get ":id/tree", to: "master_decks#tree", on: :collection
        resources :branches, :path => 'branch', only: [:index, :show]
      end
      
    end
  
    devise_scope :user do
        get '/accounts/sign_out', to: 'devise/sessions#destroy'
      end
  
    authenticated do
    
      root to: "users#index", as: :authenticated_root
      resources :users, :path => 'u', only: [:edit, :update] 
      resources :master_decks, :path => 'decks', only: [:new, :create] do
        resources :branches, :path => 'branch', only: [:new, :create, :compare, :merge]
        get ":master_deck_id/branch/new/:branched_from_id", to: "branches#new", on: :collection
        get ":master_deck_id/branch/compare/:source_branch", to: "branches#compare", on: :collection
        post ":master_deck_id/branch/merge", to: "branches#merge", on: :collection
      end
      
      
      
    end
      
      
    
  
  
  root to: "home#index"
  

  
end


