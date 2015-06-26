class UsersController < ApplicationController
  include SessionsHelper

  def new
    @user = User.new
    render json: @user.to_json
  end

  def index
    @user = User.where(email: params[:email]).first
    if @user && @user.authenticate(params[:password])
      p @user
    log_in(@user)
    render json: @user.to_json
    else
      @response = 'Invalid email/password combination.'
    render json: @response.to_json
    end
  end

  def create
    @user = User.new(
      username: params[:username],
      email: params[:email],
      password: params[:password],
      profile_picture: params[:profile_picture]
      )
    if params[:password] == params[:password_confirmation]
      @user.save
      return 201
    else
      @error = "Password confirmation must match Password"
      render :new
    end
  end

  def appoint
    appointment = Appointment.new(
      user_id: current_user.id,
      business_id: params[:id],
      start_time: DateTime.parse(params[:begin_time]),
      end_time: DateTime.parse(params[:end_time]),
      attending: true
      )
    appointment.save!
    p user = current_user
    render json: current_user.to_json
  end
end


