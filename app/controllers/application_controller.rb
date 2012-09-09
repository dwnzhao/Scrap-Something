class ApplicationController < ActionController::Base
  protect_from_forgery

  protected 
  def confirm_logged_in
    unless session[:user_id]
      flash[:notice] = "please log in or sign up."
      redirect_to(:action => '../access/index')
      return false
    else 
      return true
    end
  end

end
