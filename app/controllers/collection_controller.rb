class CollectionController < ApplicationController
  layout 'collection'
  respond_to :html, :js
  before_filter :confirm_logged_in, :except => []

  def index
    redirect_to(:action => 'view_collection')
  end

  def view_collection
    user = get_session_user
    @categories = Category.all
    @collection = user.scraps
    @shared_collection = user.bookmarked_scraps
    render :layout => 'view_collection'
  end

  def view_collection_detail
    @scrap = Scrap.find(params[:id])
    @categories = get_category_names(@scrap)
    @images = @scrap.images
    render :layout => 'collection_detail'
  end

  def browse_collection
    user = get_session_user
    @categories = Category.all
    @shared_collection = user.bookmarked_scraps 
    @collection = Scrap.where("creator_id != ?", session[:user_id]).where(:visibility => true) - @shared_collection
    render :layout => 'browse_collection'
  end

  def browse_collection_detail
    @scrap = Scrap.find(params[:id]) 
    @categories = get_category_names(@scrap)
    @images = @scrap.images
    render :layout => 'collection_detail'
  end
  
  def browse_bookmarked_collection_detail
    @scrap = Scrap.find(params[:id]) 
    @categories = get_category_names(@scrap)
    render :layout => 'view_collection'
  end
  
  def search
  user = get_session_user
  shared_collection = user.bookmarked_scraps 
  user_owned = Scrap.where("creator_id == ?", session[:user_id])
  @categories = Category.all
  @collection = Scrap.search(params[:search]) - shared_collection - user_owned
  render('collection/browse_collection')
  end
  
  def filter
     user = get_session_user
     shared_collection = user.bookmarked_scraps 
     @categories = Category.all
     @collection = Category.find(params[:id]).scraps.where("creator_id != ?", session[:user_id]).where(:visibility => true) - shared_collection
     render 'collection/browse_collection', :layout => 'view_collection'
  end
  
  def organize_collection
  end


end
