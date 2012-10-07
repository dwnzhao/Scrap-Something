class CollectionController < ApplicationController
  layout 'view_collection'
  respond_to :html, :js
  before_filter :confirm_logged_in, :except => [:browse_collection, :search, :filter]

  def index
    redirect_to(:action => 'browse_collection')
  end

  def view_collection
    @user = get_session_user
    @categories = Category.all
    @collection = @user.collections.all
    if (params[:collection].blank?)
      @selected_collection = get_all_user_scraps
    else
      @selected_collection = Collection.find(params[:collection]).scraps
    end
  end

  def browse_collection
    @categories = Category.all
    if (session[:user_id])
      @collection = Scrap.all - get_all_user_scraps
    else
      @collection = Scrap.all
    end
  end

  def search
    @categories = Category.all
    if (session[:user_id])
      user = get_session_user
      shared_collection = user.collections('bookmarked')
      user_owned = Scrap.where("creator_id == ?", session[:user_id])
      @collection = Scrap.search(params[:search]) - shared_collection - user_owned
    else
      @collection = Scrap.search(params[:search])
    end
    render(:template => "collection/browse_collection")
  end

  def filter
    if(params[:user_specific])
      @selected_collection = Category.find(params[:id]).scraps & get_all_user_scraps
      @user = get_session_user
      @categories = Category.all
      @collection = @user.collections.all
      render("collection/view_collection")
    else
      @collection = Category.find(params[:id]).scraps
    end
  end

  def organize_collection
  end

  def get_all_user_scraps
    user = get_session_user
    collection_all = user.collections
    selected_collection = []
    collection_all.each_with_index do |collection, index|
      selected_collection = selected_collection + collection.scraps
    end
    return selected_collection
  end


end
