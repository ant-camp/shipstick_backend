Rails.application.routes.draw do
  resources :products, except: :show do
    get 'find_by_dimensions', to: 'products#show', on: :collection
  end
end
