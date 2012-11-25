class ShareController < ApplicationController

  before_filter :confirm_logged_in, :except => []

  def bookmark
    scrap = Scrap.find(params[:scrap_id])
    get_session_user.collections.bookmarked.scraps << scrap
    scrap.update_attribute(:number_of_shares, scrap.number_of_shares + 1)
    redirect_to(:action => 'browse_collection', :controller => 'collection')
  end

  def remove_bookmark
    scrap = Scrap.find(params[:scrap_id])
    user = get_session_user
    if(user.collections.bookmarked.scraps.include?(scrap))
      user.collections.bookmarked.scraps.destroy(scrap) 
    end
    redirect_to(:action => 'view_collection', :controller => 'collection')
  end
  
  def favor
    scrap = Scrap.find(params[:scrap_id])
    get_session_user.collections.favorite.scraps << scrap
    scrap.update_attribute(:number_of_shares, scrap.number_of_shares + 1)
    redirect_to(:action => 'view_collection', :controller => 'collection')
  end
  
  def defavor
    scrap = Scrap.find(params[:scrap_id])
    get_session_user.collections.favorite.scraps.destroy(scrap)
    redirect_to(:action => 'view_collection', :controller => 'collection')
  end
  
end
