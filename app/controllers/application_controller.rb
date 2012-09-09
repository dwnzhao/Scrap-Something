class ApplicationController < ActionController::Base
  protect_from_forgery

  protected 

  def get_session_user
    return User.find(session[:user_id])
  end
  
  def get_category_names(scrap)
    return scrap.categories.select("name").map {|x| x.name}
  end
  
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
