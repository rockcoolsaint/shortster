Rails.application.routes.draw do
  get '/:shortcode', to: 'links#show'
  get '/:shortcode/stats', to: 'links#stats'
  post '/submit', to: 'links#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
