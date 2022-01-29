# frozen_string_literal: true

class OrganisationInteractionController < ApplicationController
  def organisation
    id = params[:id].to_i
    @current_organisation = Organisation.find_by_id(id)
    unless @current_organisation
      redirect_to '/'
      return
    end
    @jobs_count = @current_organisation.jobs.all.select do |job|
      ((@today_date - Date.strptime(job.created_at.strftime('%m.%d.%Y'), '%m.%d.%Y')).to_i * 24) < 720
    end.length
    @has_access = false
    @has_access = true if @organisation && (@organisation.id == @current_organisation.id)
  end

  def job
    id = params[:id].to_i
    @job = Job.find_by_id(id)
    unless @job
      redirect_to '/'
      return
    end
    @created_at = @job.created_at.strftime('%m.%d.%Y')
    if ((@today_date - Date.strptime(@created_at, '%m.%d.%Y')).to_i * 24) >= 720
      redirect_to '/'
      return
    end
    organisation_id = @job.organisation_id
    @current_organisation = Organisation.find_by_id(organisation_id)
    @need_to_do = @job.need_to_do.split(';')
    @has_access = false
    @has_applied = false
    if @user
      @has_applied = true if Middle.find_by_job_id_and_user_id(id, @user.id)
    elsif @organisation
      if @organisation.id == @job.organisation_id
        middles = @job.middles
        @users = middles.map { |element| User.find_by_id(element.user_id) }
        @has_access = true
      end
    end
  end

  def create_job
    unless @organisation
      redirect_to '/'
      return
    end

    name = params[:name]
    need_to_do = params[:need_to_do]
    description = params[:description]
    job = @organisation.jobs.create(name: name, need_to_do: need_to_do, description: description)
    jobs_count = @organisation.jobs.all.select do |job|
      ((@today_date - Date.strptime(job.created_at.strftime('%m.%d.%Y'), '%m.%d.%Y')).to_i * 24) < 720
    end.length
    new_description = description.split.select.with_index { |_element, index| index < 8 }.join(' ')

    respond_to do |format|
      format.json do
        render json:
            { id: job.id, description: new_description, jobs_count: jobs_count, is_valid: job.valid? }
      end
    end
  end

  def add_worker
    if !@account || @organisation
      redirect_to '/'
      return
    end

    job_id = params[:job_id].to_i
    summary = params[:summary]
    @user.middles.create(summary: summary, job_id: job_id)
    redirect_to "/job/#{job_id}"
  end
end
