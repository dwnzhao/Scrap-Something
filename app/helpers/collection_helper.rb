module CollectionHelper
  
  def logged_in?
  return true if(session[:user_id] != nil)
  return false
  end
  
  def scrap_favorite?(scrap)
     return true if(user_favorite.include?(scrap))
     return false
  end
  
end
