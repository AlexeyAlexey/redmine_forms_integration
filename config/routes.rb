# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html


namespace :api do
  scope module: :v1 do
    resources :forms_integration#, only: [:create]
    resources :request_from_form
    
  end
end

