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
      redirect_to(:action => 'landing_page', :controller => 'access')
      return false
    else 
      return true
    end
  end

  def get_categories_from(cat_list)
    cat_list = [] if cat_list.blank?
    return cat_list.collect {|cid| Category.find_by_id(cid.to_i)}.compact
  end

  def get_user_authorization(scrap)
    if scrap.creator_id == session[:user_id]
      return true
    else
      return false
    end
  end

  def get_bookmark_status(scrap)
    user = get_session_user
    bookmarked_scraps = user.bookmarked_scraps
    if bookmarked_scraps.include?(scrap)
      return true
    else
      return false
    end
  end

end
