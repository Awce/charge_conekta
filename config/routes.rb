Rails.application.routes.draw do

  get 'charges/index'
  post 'charges/create'
  get 'charges/show'

  root 'charges#index'

end
