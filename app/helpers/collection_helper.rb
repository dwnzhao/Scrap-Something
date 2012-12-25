module CollectionHelper

  def logged_in?
    return true if(session[:user_id] != nil)
    return false
  end

  def scrap_favorite?(scrap)
    return true if(user_favorite.include?(scrap))
    return false
  end

  def menu_nav_current?(page)
    html = ''
    if current_page?(:action => page) 
      html << "<li class='active'>"
    else
      html << "<li>"
    end
    return html.html_safe
  end

end
