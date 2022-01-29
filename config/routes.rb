# frozen_string_literal: true

Rails.application.routes.draw do
  root 'base#index'

  get '/organisation/:id' => 'organisation_interaction#organisation'
  get '/job/:id' => 'organisation_interaction#job'
  post '/create_job' => 'organisation_interaction#create_job'
  post '/add_worker' => 'organisation_interaction#add_worker'

  get '/login' => 'user_interaction#login'
  get '/logout' => 'user_interaction#logout'
  get '/register' => 'user_interaction#register'
  post '/auth' => 'user_interaction#auth'
  post '/create_new_user' => 'user_interaction#create_new_user'
  post '/create_new_organisation' => 'user_interaction#create_new_organisation'
end
