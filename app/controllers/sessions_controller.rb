class SessionsController < ApplicationController
  def new

  end


  def create
    user = User.find_by(username: params[:username])
    
    if user && user.authenticate(params[:password])
      if user.two_factor_auth?
        session[:two_factor] = true
        user.generate_pin!
        user.send_pin_to_twilio
        redirect_to pin_path
      else
        login_user!(user)
      end
    else
      flash[:error] = "Sorry, the username or password you entered was incorrect."
      redirect_to login_path
    end
  end


  def destroy
    session[:user_id] = nil
    flash[:notice] = "You are now logged out."
    redirect_to root_path
  end


  def pin
    if session[:two_factor].nil?
      flash[:error] = "Oops! You don't have permission for that."
      redirect_to root_path
    end

    if request.post?
      user = User.find_by(pin: params[:pin])
      if user
        session[:two_factor] = nil
        user.remove_pin!
        login_user!(user)
      else
        flash[:error] = "Sorry, your PIN didn't match."
        redirect_to pin_path
      end
    end
  end # pin


  private

  def login_user!(user)
    session[:user_id] = user.id
    flash[:notice] = "Welcome, you've successfully logged in."
    redirect_to root_path
  end

end