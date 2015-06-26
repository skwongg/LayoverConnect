class SessionsController < ApplicationController
  def new
    @error
  end

  def create
    p params
    @user = HTTParty.get("http://localhost:3000/users", {query: {email: params[:session][:email], password: params[:session][:password]}}).parsed_response
    if @user != 'Invalid email/password combination.'
      redirect_to '/terminals'
    else
      # Create an error message.
      @error = 'Invalid email/password combination.'
     # ## render 'new'
      redirect_to root_url
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  def fbcreate
    user = User.from_omniauth(env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to '/terminals'
  end
end
