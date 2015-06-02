# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html


namespace :api, defaults: { format: 'json' } do
  scope module: :v1 do
    resources :request_from_form
  end
end

#resources :forms_integration#, only: [:create]

