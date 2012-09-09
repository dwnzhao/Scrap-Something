class CollectionController < ApplicationController

  before_filter :confirm_logged_in, :except => []

  def index
    redirect_to(:action => 'view_collection')
  end

  def view_collection
    user = get_session_user
    @categories = Category.all
    @collection = user.scraps
    @shared_collection = user.bookmarked_scraps
  end

  def view_collection_detail
    @scrap = Scrap.find(params[:id])
    @categories = get_category_names(@scrap)
  end

  def browse_collection
    user = get_session_user
    @categories = Category.all
    @shared_collection = user.bookmarked_scraps 
    @collection = Scrap.where("creator_id != ?", session[:user_id]).where(:visibility => true) - @shared_collection
  end

  def browse_collection_detail
    @scrap = Scrap.find(params[:id]) 
    @categories = get_category_names(@scrap)
  end
  
  def browse_bookmarked_collection_detail
    @scrap = Scrap.find(params[:id]) 
    @categories = get_category_names(@scrap)
  end
  

  def add_scrap
    @scrap = Scrap.new
    @categories = Category.all
  end

  def edit_scrap
    @scrap = Scrap.find(params[:id])
    @categories = Category.all
  end

  def update_scrap
    @scrap = Scrap.find(params[:id])
    checked_categories = get_categories_from(params[:categories])
    remove_categories = Category.all - checked_categories
    if @scrap.update_attributes(params[:scrap])
      checked_categories.each {|cat| @scrap.categories << cat if !@scrap.categories.include?(cat)}
      remove_categories.each {|cat| @scrap.categories.destroy(cat) if @scrap.categories.include?(cat)}
      flash[:notice] = "edits saved."
      redirect_to(:action => 'view_collection')
    else
      @categories = Category.all
      render('edit_scrap')
    end
  end

  def save_add_scrap
    @scrap = Scrap.new(params[:scrap])
    @scrap.creator_id = session[:user_id]
    checked_categories = get_categories_from(params[:categories])
    remove_categories = Category.all - checked_categories
    @scrap.save
    if !@scrap.new_record?
      checked_categories.each {|cat| @scrap.categories << cat if !@scrap.categories.include?(cat)}
      remove_categories.each {|cat| @scrap.categories.destroy(cat) if @scrap.categories.include?(cat)}
      flash[:notice] = "... scrap added ..."
      redirect_to(:action => 'view_collection')
    else
      @categories = Category.all
      render('add_scrap')
    end
  end

  def delete_scrap
    @scrap = Scrap.find(params[:id])
  end

  def destroy_scrap
    Scrap.find(params[:id]).destroy
    flash[:notice] = "... scrap deleted ..."
    redirect_to(:action => 'view_collection')
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
     render('collection/browse_collection')
  end
  
  private #--------------------
  
  def get_categories_from(cat_list)
    cat_list = [] if cat_list.blank?
    return cat_list.collect {|cid| Category.find_by_id(cid.to_i)}.compact
  end


end
