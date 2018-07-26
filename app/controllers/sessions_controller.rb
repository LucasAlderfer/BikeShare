class SessionsController < ApplicationController

  def new

  end

  def index

  end

  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      # TODO: success flash message
      session[:user_id] = user.id
      if user.admin?
        redirect_to admin_dashboard_path
      else
        redirect_to dashboard_path
      end
    else
      # TODO: error flash message
      render :new
    end
  end

  def destroy
    @current_user = nil
    session[:user_id] = nil
    session[:cart] = nil
    flash[:notice] = 'You have been logged out!'
    redirect_to root_path
  end

end
