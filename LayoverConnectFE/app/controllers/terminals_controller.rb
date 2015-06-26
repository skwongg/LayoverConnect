class TerminalsController < ApplicationController

  def create
    HTTParty.get("localhost:3000/terminals/#{params[:terminal]}")
  end

  def index
    p params
    p session[:session_id]
    p "*" * 80
  end

end
