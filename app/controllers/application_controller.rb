# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :check_auth, :get_today_date

  private def check_auth
    if @account = Account.find_by_session_id(session[:session_id])
      user_id = @account.user_id
      organisation_id = @account.organisation_id
      @user = User.find_by_id(user_id)
      @organisation = Organisation.find_by_id(organisation_id)
    end
  end

  private def get_today_date
    @today_date = Date.strptime(Time.now.strftime('%m/%d/%Y'), '%m/%d/%Y')
  end
end
