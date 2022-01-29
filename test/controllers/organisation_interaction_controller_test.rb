# frozen_string_literal: true

require 'test_helper'

class OrganisationInteractionControllerTest < ActionDispatch::IntegrationTest
  test 'should get organisation/:id' do
    @organisation = Organisation.new(name: 'Example Name', description: 'Something can be here',
                                     website_url: 'example.com', email: 'organisation@example.com', phone: '89150051555', password: '00001')
    @organisation.save
    get "/organisation/#{@organisation.id}"
    assert_response :success
  end

  test 'should get job/:id' do
    @organisation = Organisation.new(name: 'Example Name', description: 'Something can be here',
                                     website_url: 'example.com', email: 'organisation@example.com', phone: '89150051555', password: '00001')
    @organisation.save
    @job = @organisation.jobs.create(name: 'Example Job', description: 'Something can be here',
                                     need_to_do: "let's do it")
    get "/job/#{@job.id}"
    assert_response :success
  end
end
