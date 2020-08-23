Rails.application.routes.draw do
  devise_for :users, :path => 'accounts' 
  
    
    resources :users, :path => 'u', only: [:index, :show] do
      resources :master_decks, :path => 'decks', only: [:index, :show]
      
    end
  
  
    authenticated do
    
      root to: "dashboard#index", as: :authenticated_root
      
      resources :master_decks, :path => 'decks', only: [:new, :create] 
      
    end
      
      
    
  
  
  root to: "home#index"
  

  
end


