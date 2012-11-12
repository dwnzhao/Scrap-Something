class ApplicationController < ActionController::Base
  protect_from_forgery

  protected 

  def get_session_user(*logged_in)
    if (logged_in[0] == false)
      @current_user = ''
    else
      @current_user ||= User.find(session[:user_id])
      return @current_user
    end
  end

  def get_category_names(scrap)
    return scrap.categories.select("name").map {|x| x.name}
  end

  def confirm_logged_in
    unless session[:user_id]
      flash[:warning] = "Please log in or sign up."
      render('access/landing_page', :layout => 'layouts/access')
      return false
    else 
      return true
    end
  end

  def confirm_vendor_authorization
    unless session[:user_id]
      flash[:warning] = "Please log in or sign up."
      render('access/landing_page', :layout => 'layouts/access')
      return false 
    else
      if (get_session_user.user_level > 1)
        return true
      else 
        return false
      end
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
    if user.collections.bookmarked.scraps.include?(scrap)
      return true
    else
      return false
    end
  end

  def get_all_user_scraps
    user = get_session_user
    collection_all = user.collections
    selected_collection = []
    collection_all.each_with_index do |collection, index|
      selected_collection = selected_collection + collection.scraps
    end
    return selected_collection
  end

  def get_all_user_categories
    scrap_all = get_all_user_scraps
    user_categories = []
    scrap_all.each_with_index do |scrap, index|
      user_categories = user_categories + scrap.categories
    end
    return user_categories.uniq
  end

end
