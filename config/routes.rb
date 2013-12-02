Railstutor::Application.routes.draw do

  post 'main', to: 'main#create'
  post 'apply', to: 'main#apply'
  get 'veterans', to: redirect("/")
  get 'register', to: 'main#register'
  get 'google7df0dfecf855f3f2', to: 'curriculum#google7df0dfecf855f3f2'
  ["views", "controllers", "rubybasics", "models", "mvcroundtrip", "rubyobjects", "overview" ].each do |lesson|
    get "curriculum/#{lesson}", to: "curriculum##{lesson}"
  end
  get "curriculum/", to: "curriculum#overview"
  get "curriculum", to: "curriculum#overview"
  root :to  => "main#index"
end
