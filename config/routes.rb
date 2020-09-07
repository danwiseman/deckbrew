Rails.application.routes.draw do
  devise_for :users, :path => 'accounts' 
  
    
    resources :users, :path => 'u', only: [:index, :show] do
      resources :master_decks, :path => 'decks', only: [:index, :show] do
        get ":id/tree", to: "master_decks#tree", on: :collection
        get ":id/branch", to: "master_decks#show", on: :collection
        get ":id/branch/:branch_id", to: "master_decks#show", on: :collection
        get ":id/fork", to: "master_decks#fork_deck", on: :collection
        get ":id/fork/:branch_id", to: "master_decks#fork_deck", on: :collection
        get ":id/branches", to: "master_decks#list_branches", on: :collection
      end
      
    end
    
    get "no_permission", to: 'master_decks#no_permission'
  
    devise_scope :user do
        get '/accounts/sign_out', to: 'devise/sessions#destroy'
      end
  
    authenticated do
    
      root to: "users#index", as: :authenticated_root
      resources :users, :path => 'u', only: [:edit, :update] 
      resources :master_decks, :path => 'decks', only: [:new, :create] do
        resources :branches, :path => 'branch', only: [:new, :create, :compare, :merge, :edit]
        
        # Branch Actions
        get ":master_deck_id/branch/new/:branched_from_id", to: "branches#new", on: :collection
        get ":master_deck_id/branch/edit/:branch_id", to: "branches#edit", on: :collection
        get ":master_deck_id/branch/compare/:source_branch", to: "branches#compare", on: :collection
        get ":master_deck_id/branch/delete/:branch_id", to: "branches#delete", on: :collection
        post ":master_deck_id/branch/merge", to: "branches#merge", on: :collection
        patch ":master_deck_id/branch/:branch_id", to: "branches#update", on: :collection
        
        # Deck Actions. Create is not neccessary as the deck should already exist
        get ":master_deck_id/branch/:branch_id/editcards", to: "decks#edit", on: :collection
        
        # other master deck actions
        post "fork", to: "master_decks#create_fork", on: :collection
      end
      
      
      
    end
      
      
    
  
  
  root to: "home#index"
  

  
end


