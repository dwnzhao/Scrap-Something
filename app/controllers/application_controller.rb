class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :vendor_authorization?, :user_favorite, :get_session_user

  protected 

  def get_session_user(*logged_in)
    if (logged_in[0] == false)
      @current_user = ''
    elsif session[:user_id].blank?
      return ''
    else
      @current_user ||= User.find(session[:user_id])
      return @current_user
    end
  end

  def user_favorite
    return [] if session[:user_id].blank? || get_session_user.collections.favorite.nil?
    return get_session_user.collections.favorite.scraps.uniq
  end

  def confirm_logged_in
    unless session[:user_id]
      flash.now[:warning] = "Please log in or sign up."
      render('/collection/landing_page', :layout => 'standard')
      return false
    else 
      return true
    end
  end

  def confirm_test_authorization
    unless session[:test_id]
      flash.now[:warning] = "please log in"
      render('/access/test_access', :layout => false)
      return false
    end
    return true
  end

  def confirm_vendor_authorization
    unless (get_session_user.user_level > 1)
      flash.now[:warning] = "You must be a vendor to perform this task"
      redirect_to(:action => "view_collection", :controller => "collection")
      return false
    else 
      return true
    end
  end

  def vendor_authorization?
    return false unless session[:user_id]
    return true if (get_session_user.user_level > 1)
    return false    
  end

  def process_tabs(tabs, scrap)
    checked_tabs = get_tabs_from(tabs)
    remove_tabs = get_session_user.tabs - checked_tabs
    checked_tabs.each {|tab| scrap.tabs << tab if !scrap.tabs.include?(tab)}
    remove_tabs.each {|tab| scrap.tabs.destroy(tab) if scrap.tabs.include?(tab)}
  end

  def process_keywords(keywords, scrap)
    full_list = keywords.split(",")
    clean_list = []
    full_list.each {|keyword| clean_list << keyword.strip}
    clean_list.each do |keyword|
      k = Keyword.find_by_name(keyword)
      if k.nil?  
        k = Keyword.new()
        k.name = keyword
      end
      scrap.keywords << k
    end
  end

  def process_tags(tags, scrap)
    full_list = tags.split(",")
    clean_list = []
    full_list.each {|tag| clean_list << tag.strip}
    clean_list.each do |tag|
      t = Tag.find_by_name(tag)
      if t.nil?  
        t = Tag.new()
        t.name = tag
      end
      scrap.tags << t
    end
  end

  def get_tabs_from(tab_list)
    return [] if tab_list.blank?
    return tab_list.collect {|tab| Tab.find_by_id(tab.to_i)}
  end

  def get_user_authorization(scrap)
    return true if scrap.creator_id == session[:user_id]
    return false
  end

  def get_bookmark_status(scrap)
    user = get_session_user
    return true if user.collections.bookmarked.scraps.include?(scrap)
    return false
  end

  def get_favorite_status(scrap)
    user = get_session_user
    return false if user.blank?
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
    return selected_collection.uniq
  end

  def get_all_user_favorite_scraps
    user = get_session_user
    collection_all = user.collections
    selected_collection = user.collections.favorite.scraps
    return selected_collection
  end

  def get_all_user_categories
    scrap_all = get_all_user_scraps
    user_categories = []
    scrap_all.each_with_index do |scrap, index|
      user_categories << scrap.category
    end
    return user_categories.uniq
  end

  def get_all_user_tags
    scrap_all = get_all_user_scraps
    user_tags = []
    scrap_all.each_with_index do |scrap, index|
      user_tags << scrap.tags
    end
    return user_tags.flatten.uniq
  end

  def get_listing(id)
    scrap = Scrap.find(id)
    return scrap.product_listings.compact
  end

  def calculate_price(price_range)
    price_array = price_range.split(" - ")
    return [price_array[0].length, price_array[1].length]
  end

  def find_scraps_by_city_and_category(city, category_id)
    if city == 'all' && !category_id
      return Scrap.all
    elsif city == 'all' && category_id
      Category.find(category_id).scraps
    else
      return ProductListing.find_all_by_metro_area(city).collect(&:scrap)
    end
  end

end
