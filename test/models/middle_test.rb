# frozen_string_literal: true

require 'test_helper'

class MiddleTest < ActiveSupport::TestCase
  def setup
    @user = User.create(name: 'Example Name', surname: 'Example Surname', email: 'user@example.com',
                        phone: '89150051550', password: '12345')
    @organisation = Organisation.new(name: 'Example Name', description: 'Something can be here',
                                     website_url: 'example.com', email: 'organisation@example.com', phone: '89150051555', password: '00001')
    @job = @organisation.jobs.new(name: 'Example Job', description: 'Something can be here',
                                  need_to_do: "let's do it")
    @middle = @job.middles.new(summary: 'Hello, i can do this', user_id: @user.id)
  end

  test 'should be valid' do
    assert @middle.valid?
  end

  test 'summary should be present' do
    @middle.summary = ''
    assert_not @middle.valid?
  end
end
