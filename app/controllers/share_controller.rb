class ShareController < ApplicationController

  before_filter :confirm_logged_in, :except => []

  def bookmark
    scrap_to_bookmark = Scrap.find(params[:id])
    user = get_session_user
    SharedScrap.create(:user => user, :bookmarked_scrap => scrap_to_bookmark)
    scrap_to_bookmark.update_attribute(:number_of_shares, scrap_to_bookmark.number_of_shares + 1)
    redirect_to(:action => 'browse_collection', :controller => 'collection')
  end

  def remove_bookmark
    scrap = Scrap.find(params[:id])
    user = get_session_user
    user.bookmarked_scraps.destroy(scrap) if user.bookmarked_scraps.include?(scrap)
    redirect_to(:action => 'view_collection', :controller => 'collection')
  end
end
