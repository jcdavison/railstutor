Railstutor::Application.routes.draw do

  post 'main', to: 'main#create'
  post 'apply', to: 'main#apply'
  get 'veterans', to: 'main#veterans'
  get 'register', to: 'main#register'
  root :to  => "main#index"
end
