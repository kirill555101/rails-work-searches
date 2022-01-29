# frozen_string_literal: true

require 'test_helper'

class UserInteractionControllerTest < ActionDispatch::IntegrationTest
  test 'should get login' do
    get '/login'
    assert_response :success
  end

  test 'should get register' do
    get '/register'
    assert_response :success
  end

  test 'should create a new user' do
    post '/create_new_user',
         params: { name: 'Example Name', surname: 'Example Surname', email: 'user@example.com', phone: '89150051550',
                   password: '12345', another_password: '12345' }
    assert_response :redirect
  end

  test 'should create a new organisation' do
    post '/create_new_organisation',
         params: { name: 'Example Name', description: 'Something can be here', website_url: 'example.com',
                   email: 'organisation@example.com', phone: '89150051555', password: '00001', another_password: '00001' }
    assert_response :redirect
  end
end
