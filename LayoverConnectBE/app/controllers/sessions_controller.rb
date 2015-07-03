class SessionsController < ApplicationController
  def create
    # @user = User.find_or_create(auth_hash)

    p '*' * 200
    p auth_hash
    p '*' * 200
    @user = User.find_or_create_from_auth_hash(auth_hash)
    # @user = User.where(auth_hash: auth_hash).first_or_create
    # self.current_user = @user
    redirect_to '/'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end