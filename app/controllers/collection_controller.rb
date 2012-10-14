class CollectionController < ApplicationController
  layout 'view_collection'
  respond_to :html, :js
  before_filter :confirm_logged_in, :except => [:browse_collection, :search, :filter]

  def index
    redirect_to(:action => 'browse_collection')
  end

  def view_collection
    @selected_collection = get_all_user_scraps
    @scrap_total = @selected_collection.size
    @user = get_session_user
    @categories = Category.all
    @collection = @user.collections.all
    if (!params[:collection].blank? && params[:collection] != 'all')
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
    if (params[:user_specific] == 'true')
      @user = get_session_user
      @categories = Category.all
      @collection = @user.collections.all
      @selected_collection = Scrap.search(params[:search_home]) & get_all_user_scraps
      if (@selected_collection.blank?)
        flash[:notice] = "... sorry, nothing found ..."
      end
      render(:template => "collection/view_collection")
    else
      @categories = Category.all
      @collection = Scrap.search(params[:search_explore])
      if (@collection.blank?)
        flash[:notice] = "... sorry, nothing found ..."
      end
      render(:template => "collection/browse_collection")
    end
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
  
  def test
    @selected_collection = get_all_user_scraps
  end


end
