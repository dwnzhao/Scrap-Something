class CollectionController < ApplicationController
  layout 'view_collection'
  respond_to :html, :js
  
  before_filter :confirm_logged_in, :except => [:browse_collection, :search, :category_filter]

  def index
    redirect_to(:action => 'browse_collection')
  end

  def view_collection
    @selected_collection = get_all_user_scraps
    @scrap_total = @selected_collection.size
    @user = get_session_user
    @categories = Category.all
    @collection = @user.collections.all
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
      @selected_collection = Scrap.search(params[:search_home]) & get_all_user_scraps
      render("collection/filter.js")
    else
      @categories = Category.all
      @collection = Scrap.search(params[:search_explore])
      flash[:info] = "... sorry, nothing found ..." if (@collection.blank?)
      render(:template => "collection/browse_collection")
    end
  end

  def category_filter
    if(params[:user_specific])
      @selected_collection = Category.find(params[:id]).scraps & get_all_user_scraps
      render("collection/filter.js")
    else
      @collection = Category.find(params[:id]).scraps
      @categories = Category.all
      render(:template => "collection/browse_collection")
    end
  end
  
  def source_filter
      @selected_collection = Collection.find(params[:id]).scraps
      render("collection/filter.js")
  end
end
