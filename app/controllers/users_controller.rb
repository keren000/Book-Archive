class UsersController < ApplicationController

  #login
  get '/login' do
    if logged_in?
      redirect '/books/index'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    user = User.find_by(:email => params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/books/index'
    else
      flash[:notice] = "Wrong password or email. Please try again!"
      redirect to '/'
    end
  end

  get '/index' do
    if logged_in?
      redirect '/books/index'
    else
      erb :'users/login'
    end
  end

  #logout
  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  #signup
  get '/signup' do
    erb :'users/signup'
    
  end

post '/signup' do
    @user = User.new(params)
    if @user.save
      session[:user_id] = @user.id
      redirect to "/login"
       #validations passed
    else
      erb :'users/signup'
        #validations failed
    end
  end

end
