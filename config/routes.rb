# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html


namespace :api do
  resources :forms_integration#, only: [:create]
end