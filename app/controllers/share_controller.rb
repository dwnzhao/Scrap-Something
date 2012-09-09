class ShareController < ApplicationController

  before_filter :confirm_logged_in, :except => []

  def bookmark
    scrap_to_bookmark = Scrap.find(params[:id])
    user = User.find(session[:user_id])
    SharedScrap.create(:user => user, :bookmarked_scrap => scrap_to_bookmark)
    redirect_to(:action => 'browse_collection', :controller => 'collection')
  end

  def remove_bookmark
    scrap = Scrap.find(params[:id])
    user = User.find(session[:user_id])
    user.bookmarked_scraps.destroy(scrap) if user.bookmarked_scraps.include?(scrap)
    redirect_to(:action => 'view_collection', :controller => 'collection')
  end
end
