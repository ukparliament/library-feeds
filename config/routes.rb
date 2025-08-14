Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  
  get '/' => 'home#index', as: :root
  get '/library-feeds' => 'home#index', as: :home
  
  get '/library-feeds/publishers' => 'publisher#index', as: :publisher_list
  get '/library-feeds/publishers/:publisher' => 'publisher#show', as: :publisher_show
  
  get '/library-feeds/meta' => 'meta#index', as: :meta_list
  get '/library-feeds/meta/cookies' => 'meta#cookies', as: :meta_cookies
end
