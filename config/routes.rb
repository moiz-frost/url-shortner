# frozen_string_literal: true

# == Route Map
#

require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  mount Sidekiq::Web => '/sidekiq'

  namespace :api do
    namespace :v1 do
      resources :urls, only: [:index, :show], param: :number do
        resources :url_views, only: [:index, :show], param: :number
      end
    end
  end

  get ':key', to: 'redirect#action', constraints: { key: Regex::BASE62_UNIQUE_CHARACTERS_REGEX }

  redirect '/'
end
