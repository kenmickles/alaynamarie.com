AlaynaMarie::Application.routes.draw do
  root :to => 'books#show', :id => 1  
  
  resources :books, :only => [:show]
  resources :photos, :only => [:show]
  resources :pages, :only => [:show]
  
  # wedding books
  match 'weddings/brides' => 'books#show', :id => 4
  match 'weddings/wedding-party' => 'books#show', :id => 5
  match 'weddings/reception' => 'books#show', :id => 6
  match 'weddings/before-and-after' => 'books#show', :id => 7
  
  # send everything else to the pages controller
  get '*url' => 'pages#show'
end
