module AccessHelper

  def logged_in?
    return true if(session[:user_id] != nil)
    return false
  end

  def scrap_favorite?(scrap)
    return true if(user_favorite.include?(scrap))
    return false
  end

  def menu_nav_current?(*pages )
    html = ''
    pages.each do |page|
      if current_page?(:action => page) 
        html << "<li class='active dropdown'>"
        break
      end
    end
    if html == ''
      html << "<li class='dropdown'>"
    end
    return html.html_safe
  end

  def user_binder
    html = ''
    html << session[:user_first_name]
    html << "'s Binder"
    return html.html_safe
  end


end
