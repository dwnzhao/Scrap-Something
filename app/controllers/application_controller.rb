class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :confirm_vendor_authorization, :vendor_authorization?, :user_favorite

  protected 

  def get_session_user(*logged_in)
    if (logged_in[0] == false)
      @current_user = ''
    else
      @current_user ||= User.find(session[:user_id])
      return @current_user
    end
  end
  
  def user_favorite
    return get_session_user.collections.favorite.scraps
  end

  def get_category_names(scrap)
    return scrap.categories.collect(&:name)
  end

  def confirm_logged_in
    unless session[:user_id]
      flash.now[:warning] = "Please log in or sign up."
      render('access/landing_page', :layout => 'layouts/access')
      return false
    else 
      return true
    end
  end

  def confirm_vendor_authorization
    unless session[:user_id]
      flash.now[:warning] = "Please log in or sign up."
      render('access/landing_page', :layout => 'layouts/access')
      return false 
    else
      return true if (get_session_user.user_level > 1)
      return false
    end
  end
  
  def vendor_authorization?
    return false unless session[:user_id]
    return true if (get_session_user.user_level > 1)
    return false    
  end
  
  def process_categories(categories, scrap)
    checked_categories = get_categories_from(categories)
    remove_categories = Category.all - checked_categories
    checked_categories.each {|cat| scrap.categories << cat if !scrap.categories.include?(cat)}
    remove_categories.each {|cat| scrap.categories.destroy(cat) if scrap.categories.include?(cat)}
  end
    

  def get_categories_from(cat_list)
    cat_list = [] if cat_list.blank?
    return cat_list.collect {|cat| Category.find_by_id(cat.to_i)}
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
    return true if user.collections.bookmarked.scraps.include?(scrap)
    return false
  end
  
  def get_favorite_status(scrap)
    user = get_session_user
    return true if user.collections.favorite.scraps.include?(scrap)
    return false
  end
  

  def get_all_user_scraps
    user = get_session_user
    collection_all = user.collections
    selected_collection = []
    collection_all.each_with_index do |collection, index|
      selected_collection += collection.scraps
    end
    return selected_collection
  end

  def get_all_user_categories
    scrap_all = get_all_user_scraps
    user_categories = []
    scrap_all.each_with_index do |scrap, index|
      user_categories += scrap.categories
    end
    return user_categories.uniq
  end
  
  def get_listing(id)
    scrap = Scrap.find(id)
    return scrap.product_listings
  end

end
