Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  
  
  authenticated do
    
    root to: "dashboard#index", as: :authenticated_root
    
    # Decks
    get 'decks', :to => 'master_decks#index'
    get 'decks/new', :to => 'master_decks#new'
    post 'decks/new', :to => 'master_decks#create'
    get 'decks/:id', :to => 'master_decks#show', as: 'master_deck'
    
  end
  
  root to: "home#index"
  
end
