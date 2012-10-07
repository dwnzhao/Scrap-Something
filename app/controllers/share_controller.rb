class ShareController < ApplicationController

  before_filter :confirm_logged_in, :except => []

  def bookmark
    scrap = Scrap.find(params[:id])
    user = get_session_user
    user.collections.find_by_name('bookmarked').scraps << scrap
    scrap.update_attribute(:number_of_shares, scrap.number_of_shares + 1)
    redirect_to(:action => 'browse_collection', :controller => 'collection')
  end

  def remove_bookmark
    scrap = Scrap.find(params[:id])
    user = get_session_user
    user.collections.find_by_name('bookmarked').scraps.destroy(scrap) if user.collections.find_by_name('bookmarked').scraps.include?(scrap)
    redirect_to(:action => 'view_collection', :controller => 'collection')
  end
end
