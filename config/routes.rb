Rails.application.routes.draw do
  root to: 'characters#index'

  resources :stories
  resources :characters do
    collection do
      delete :destroy_all
    end
  end
  # map.resources rushing_offenses, :collection => { :destroyall =>
  #                                                      :delete }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
