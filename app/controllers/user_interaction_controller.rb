# frozen_string_literal: true

class UserInteractionController < ApplicationController
  def login
    redirect_to '/' if @account

    @error = params[:error].nil? ? '' : params[:error]
  end

  def logout
    @account&.destroy

    redirect_to '/'
  end

  def auth
    redirect_to '/' if @account

    email = params[:email]
    password = Digest::SHA1.hexdigest params[:password]

    error = ''
    if (user = User.find_by_email(email)) || (organisation = Organisation.find_by_email(email))
      if user
        if user.password == password
          user.accounts.create(session_id: session[:session_id])
        else
          error = 'Введен неверный пароль'
        end
      elsif organisation.password == password
        organisation.accounts.create(session_id: session[:session_id])
      else
        error = 'Введен неверный пароль'
      end
    else
      error = 'Пользователь/компания не найдены'
    end

    if error == ''
      redirect_to '/'
      nil
    else
      redirect_to action: 'login', error: error
      nil
    end
  end

  def register
    redirect_to '/' if @account

    @error1 = params[:error1].nil? ? '' : params[:error1]
    @error2 = params[:error2].nil? ? '' : params[:error2]
  end

  def create_new_user
    if @account
      redirect_to '/'
      return
    end

    name = params[:name]
    email = params[:email]
    surname = params[:surname]
    phone = params[:phone]
    password = params[:password]
    another_password = params[:another_password]

    if password != another_password
      redirect_to action: 'register', error1: 'Введенные пароли не совпадают'
      return
    end

    error = ''
    if user = User.find_by_email(email)
      error = 'Пользователь с такой почтой уже существует'
    end

    if user = User.find_by_phone(phone)
      error = 'Пользователь с таким номером телефона уже существует'
    end

    unless error == ''
      redirect_to action: 'register', error1: error
      return
    end

    password = Digest::SHA1.hexdigest password
    @user = User.new(name: name, surname: surname, email: email, phone: phone, password: password)
    unless @user.valid?
      redirect_to action: 'register', error1: 'Проверьте правильность введенных данных'
      return
    end
    @user.save
    @user.accounts.create(session_id: session[:session_id])

    redirect_to '/'
  end

  def create_new_organisation
    name = params[:name]
    description = params[:description]
    email = params[:email]
    website_url = params[:website_url]
    phone = params[:phone]
    password = params[:password]
    another_password = params[:another_password]

    if password != another_password
      redirect_to action: 'register', error2: 'Введенные пароли не совпадают'
      return
    end

    error = ''
    if organisation = Organisation.find_by_name(name)
      error = 'Организация с таким именем уже существует'
    end

    if organisation = Organisation.find_by_email(email)
      error = 'Организация с такой почтой уже существует'
    end

    if organisation = Organisation.find_by_website_url(website_url)
      error = 'Организация с таким сайтом уже существует'
    end

    if organisation = Organisation.find_by_phone(phone)
      error = 'Организация с таким номером телефона уже существует'
    end

    unless error == ''
      redirect_to action: 'register', error2: error
      return
    end

    password = Digest::SHA1.hexdigest password
    @organisation = Organisation.create(name: name, description: description, website_url: website_url,
                                        password: password, phone: phone, email: email)
    unless @organisation.valid?
      redirect_to action: 'register', error2: 'Проверьте правильность введенных данных'
      return
    end
    @organisation.save
    @organisation.accounts.create(session_id: session[:session_id])

    redirect_to '/'
  end
end
