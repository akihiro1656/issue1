Rails.application.routes.draw do
  get 'home/index'
  root 'home#index'
  post 'calculate_time', to: 'home#calculate_time'
end
