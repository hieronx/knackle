Knackle::Application.routes.draw do
  resources :assignments


  resources :groups


  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

  root :to => "home#index"

  match "groups/join/:id", to: "groups#join", as: "join_groups"
  match "groups/leave/:id", to: "groups#leave", as: "leave_groups"
  
end
