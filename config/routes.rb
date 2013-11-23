Railstutor::Application.routes.draw do

  post 'main', to: 'main#create'
  post 'apply', to: 'main#apply'
  get 'veterans', to: 'main#veterans'
  get 'register', to: 'main#register'
  ["rubybasics", "models", "mvcroundtrip", "rubyobjects", "overview" ].each do |lesson|
    get "curriculum/#{lesson}", to: "curriculum##{lesson}"
  end
  get "curriculum/", to: "curriculum#overview"
  get "curriculum", to: "curriculum#overview"
  root :to  => "main#index"
end
