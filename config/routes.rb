Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: 'json'} do
    resources :relationship, only: [:create] do
      collection do
        get 'friend_list'
        get 'common_friends'
      end
    end
  end
end
