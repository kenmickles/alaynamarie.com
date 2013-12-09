AlaynaMarie::Application.routes.draw do
  root :to => 'books#show', :id => 1

  resources :books, :only => [:show]
  resources :pages, :only => [:show]

  # wedding books
  match 'weddings/brides' => 'books#show', :id => 4
  match 'weddings/wedding-party' => 'books#show', :id => 5
  match 'weddings/reception' => 'books#show', :id => 6
  match 'weddings/before-and-after' => 'books#show', :id => 7

  # control panel
  namespace :admin do
    root :to => 'books#index'
    resources :books, :only => [:index, :edit, :update]
    resources :pages, :only => [:index, :edit, :update]
    resources :photos, :except => [:index, :show]
    resources :settings, :only => [:index, :edit, :update]
  end

  # Send /login to the admin section
  match '/login' => redirect("/admin/")

  # send everything else to the pages controller
  get '*url' => 'pages#show'
end
