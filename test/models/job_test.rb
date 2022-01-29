# frozen_string_literal: true

require 'test_helper'

class JobTest < ActiveSupport::TestCase
  def setup
    @organisation = Organisation.new(name: 'Example Name', description: 'Something can be here',
                                     website_url: 'example.com', email: 'organisation@example.com', phone: '89150051555', password: '00001')
    @job = @organisation.jobs.new(name: 'Example Job', description: 'Something can be here', need_to_do: "let's do it")
  end

  test 'should be valid' do
    assert @job.valid?
  end

  test 'name should be present' do
    @job.name = ''
    assert_not @job.valid?
  end

  test 'description should be present' do
    @job.description = ''
    assert_not @job.valid?
  end

  test 'need_to_do should be present' do
    @job.need_to_do = ''
    assert_not @job.valid?
  end

  test 'name should not be too long' do
    @job.name = 'a' * 51
    assert_not @job.valid?
  end

  test 'need_to_do should not be too long' do
    @job.need_to_do = 'a' * 101
    assert_not @job.valid?
  end
end
