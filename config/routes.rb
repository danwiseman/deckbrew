Rails.application.routes.draw do
  devise_for :users, :path => 'accounts' 
  
    
    resources :users, :path => 'u', only: [:index, :show] do
      resources :master_decks, :path => 'decks', only: [:index, :show] do
        resources :branches, :path => 'branch', only: [:index, :show]
      end
      
    end
  
  
    authenticated do
    
      root to: "dashboard#index", as: :authenticated_root
      
      resources :master_decks, :path => 'decks', only: [:new, :create] do
        resources :branches, :path => 'branch', only: [:new, :create]
      end
      
    end
      
      
    
  
  
  root to: "home#index"
  

  
end


