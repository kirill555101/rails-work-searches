# frozen_string_literal: true

require 'digest/sha1'

class BaseController < ApplicationController
  def index
    @organisations = Organisation.all
    @jobs = Job.all.select do |job|
      ((@today_date - Date.strptime(job.created_at.strftime('%m.%d.%Y'), '%m.%d.%Y')).to_i * 24) < 720
    end
  end
end
