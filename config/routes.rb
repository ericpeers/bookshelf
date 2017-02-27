Rails.application.routes.draw do
  resources :books do
    #ratings apply to a book, and a user (eventually. Maybe). So place them under books for now.
    resources :ratings
  end


  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
