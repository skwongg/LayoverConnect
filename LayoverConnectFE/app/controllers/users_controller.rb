class UsersController < ApplicationController
  def new
    @user = 'abc'
  end

  def create
    xyz = HTTParty.post("http://localhost:3000/users",
      {:body => {username: params[:abc][:username],
      email: params[:abc][:email],
      password: params[:abc][:password],
      password_confirmation: params[:abc][:password_confirmation],
      profile_picture: "https://lh3.googleusercontent.com/-6OPxbzMH3IA/AAAAAAAAAAI/AAAAAAAAGPQ/3A7tdz6xYMM/photo.jpg"}.to_json,
      :headers => { 'Content-Type' => 'application/json', 'Accept' => 'application/json'}}
      )
      redirect_to '/terminals'

      # if params[:user][:password] == params[:user][:password_confirmation]
      #   @user.save
      #   log_in(@user)
      #   redirect_to '/terminals'
      # else
      #   @error = "Password confirmation must match Password"
      #   render :new
      # end
  end

  def appoint
    p params

    # appointment = Appointment.new(
      appointment = {
        # user_id: current_user.id,
        business_id: params[:id],
        start_time: DateTime.parse(params[:begin_time]),
        end_time: DateTime.parse(params[:end_time]),
        attending: true}

      request = HTTParty.post("http://localhost:3000/users/appointment/#{params[:id]}", :body => {'appointment' => appointment})
      # p request.parsed_response

      render json: request.to_json
      # )
    # appointment.save!
    # p user = current_user
    # render json: current_user.to_json
  end
end

