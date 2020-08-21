Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  
  
  scope '/decks' do
    resources :master_decks
  end
    
end
