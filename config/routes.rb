Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  get ':username/decks', :to => 'master_decks#index'
  get ':username/:master_deck_name', :to => 'master_decks#show', as: 'master_deck'
  
  authenticated do
    
    root to: "dashboard#index", as: :authenticated_root
    
    # Decks

    get ':username/decks/new', :to => 'master_decks#new'
    post ':username/decks/new', :to => 'master_decks#create'
    
    
  end
  
  root to: "home#index"
  
end
