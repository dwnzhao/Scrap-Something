class CollectionController < ApplicationController
  layout 'view_collection'
  respond_to :html, :js
  before_filter :confirm_logged_in, :except => [:browse_collection, :search, :filter]

  def index
    redirect_to(:action => 'browse_collection')
  end

  def view_collection
    user = get_session_user
    @categories = Category.all
    @collection = user.scraps
    @shared_collection = user.bookmarked_scraps
  end

  def browse_collection
    @categories = Category.all
    if (session[:user_id])
      user = get_session_user
      shared_collection = user.bookmarked_scraps 
      @collection = Scrap.where("creator_id != ?", session[:user_id]).where(:visibility => true) - shared_collection
    else 
      @collection = Scrap.all
    end
  end

  def search
    @categories = Category.all
    if (session[:user_id])
      user = get_session_user
      shared_collection = user.bookmarked_scraps 
      user_owned = Scrap.where("creator_id == ?", session[:user_id])
      @collection = Scrap.search(params[:search]) - shared_collection - user_owned
    else
      @collection = Scrap.search(params[:search])
    end
    render(:template => "collection/browse_collection")
  end

  def filter
    @categories = Category.all
    if (session[:user_id])
      user = get_session_user
      shared_collection = user.bookmarked_scraps 
      @collection = Category.find(params[:id]).scraps.where("creator_id != ?", session[:user_id]).where(:visibility => true) - shared_collection
    else
      @collection = Category.find(params[:id]).scraps
    end
    render("collection/browse_collection")
  end

  def organize_collection
  end


end
