AlaynaMarie::Application.routes.draw do
  resources :books, :only => [:show]
  resources :photos, :only => [:show]
  resources :pages, :only => [:show]
  
  root :to => 'books#show', :id => 1
  
  # send everything else to the pages controller
  get '*url' => 'pages#show'
end
