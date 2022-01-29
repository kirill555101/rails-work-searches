# frozen_string_literal: true

require 'test_helper'

class WebsiteCapabilitiesTest < ActionDispatch::IntegrationTest
  test 'can register a new user and create a summary from him' do
    post '/create_new_user',
         params: { name: 'Example Name', surname: 'Example Surname', email: 'user@example.com', phone: '89150051550',
                   password: '12345', another_password: '12345' }
    assert_response :redirect

    @organisation = Organisation.new(name: 'Example Name', description: 'Something can be here',
                                     website_url: 'example.com', email: 'organisation@example.com', phone: '89150051555', password: '00001')
    @organisation.save
    @job = @organisation.jobs.create(name: 'Example Job', description: 'Something can be here',
                                     need_to_do: "let's do it")

    post '/add_worker', params: { job_id: @job.id, summary: 'example summary' }
    assert_response :redirect
  end

  test 'can register a new organisation and create a job from it' do
    post '/create_new_organisation',
         params: { name: 'Example Name', description: 'Something can be here', website_url: 'example.com',
                   email: 'organisation@example.com', phone: '89150051555', password: '00001', another_password: '00001' }
    assert_response :redirect

    post '/create_job', params: { name: 'Example Job', need_to_do: 'Some needs', description: 'Here is a new job' }
    assert_response :redirect
  end
end
