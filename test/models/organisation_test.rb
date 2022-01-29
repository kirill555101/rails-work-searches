# frozen_string_literal: true

require 'test_helper'

class OrganisationTest < ActiveSupport::TestCase
  def setup
    @organisation = Organisation.new(name: 'Example Name', description: 'Something can be here',
                                     website_url: 'example.com', email: 'organisation@example.com', phone: '89150051555', password: '00001')
  end

  test 'should be valid' do
    assert @organisation.valid?
  end

  test 'name should be present' do
    @organisation.name = ''
    assert_not @organisation.valid?
  end

  test 'description should be present' do
    @organisation.description = ''
    assert_not @organisation.valid?
  end

  test 'email should be present' do
    @organisation.email = ''
    assert_not @organisation.valid?
  end

  test 'phone should be present' do
    @organisation.phone = ''
    assert_not @organisation.valid?
  end

  test 'website_url should be present' do
    @organisation.website_url = ''
    assert_not @organisation.valid?
  end

  test 'phone validation should accept valid phones' do
    valid_phones = %w[89170004045 89161115522 89159998765]
    valid_phones.each do |valid_phone|
      @organisation.phone = valid_phone
      assert @organisation.valid?, "#{valid_phones.inspect} should be valid"
    end
  end

  test 'email validation should accept valid addresses' do
    valid_addresses = %w[organisation@example.com ORGANISATION@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @organisation.email = valid_address
      assert @organisation.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test 'emails and logins should be unique' do
    duplicate_organisation = @organisation.dup
    @organisation.save
    assert_not duplicate_organisation.valid?
  end

  test 'name should not be too long' do
    @organisation.name = 'a' * 51
    assert_not @organisation.valid?
  end

  test 'website_url should not be too long' do
    @organisation.website_url = 'a' * 51
    assert_not @organisation.valid?
  end

  test 'email should not be too long' do
    @organisation.email = "#{'a' * 244}@example.com"
    assert_not @organisation.valid?
  end

  test 'phone should not be too long' do
    @organisation.phone = '1' * 100
    assert_not @organisation.valid?
  end
end
