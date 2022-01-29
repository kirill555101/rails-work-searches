# frozen_string_literal: true

require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  def setup
    @organisation = Organisation.new(name: 'Example Name', description: 'Something can be here',
                                     website_url: 'example.com', email: 'organisation@example.com', phone: '89150051555', password: '00001')
    @user = User.new(name: 'Example Name', surname: 'Example Surname', email: 'user@example.com', phone: '89150051550',
                     password: '12345')
    @account = @organisation.accounts.new(session_id: 'c6116f7395b34412ad0aea3c9b8d4bfa', user_id: @user_id)
  end

  test 'should be valid' do
    assert @account.valid?
  end

  test 'session_id should be present' do
    @account.session_id = ''
    assert_not @account.valid?
  end
end
