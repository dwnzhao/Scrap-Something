class CollectionController < ApplicationController
  require 'will_paginate/array'

  layout 'standard'
  respond_to :html, :js

  before_filter :confirm_logged_in, :except => [:browse_collection, :search, :category_browse, :landing_page, :advanced_category_filter, :browse_by_keyword]

  before_filter :confirm_test_authorization


  def index
    redirect_to(:action => 'browse_collection')      
  end

  def view_collection
    if vendor_authorization?
      redirect_to(:action => "view_items", :controller => 'vendor')
    else
      @collection = get_all_user_scraps.paginate(:page => params[:page], :per_page => 8)
      render("collection/expand.js") if (params[:page])
      @user = get_session_user
      @categories = get_all_user_categories
      @tags = get_all_user_tags
      @vb = get_session_user.vision_boards
    end
  end

  def tab_max_error
    flash[:warning] = "you cannot add any more tabs (max 7 tabs)"
    redirect_to(:action => 'view_collection')      
  end

  def browse_collection
    if (params[:category_id])
      @collection = Category.find(params[:category_id]).scraps.paginate(:page => params[:page], :per_page => 9)
    elsif (params[:keyword_id])
      @collection = (Scrap.public_scraps & Keyword.find(params[:keyword_id]).scraps).paginate(:page => params[:page], :per_page => 9)
    elsif (session[:user_id])
      @collection = (Scrap.public_scraps - get_all_user_scraps).paginate(:page => params[:page], :per_page => 9) 
    else
      @collection = Scrap.public_scraps.paginate(:page => params[:page], :per_page => 9)
    end
    flash.now[:info] = "sorry, nothing found" if @collection.empty?
    render("collection/expand.js") if (params[:page])
    @categories = Category.all
    @cities = City.all.collect(&:city)
  end

  def category_filter
    if params[:favorite]
      @selected_collection = get_all_user_favorite_scraps
      render("collection/filter_home.js")
    elsif params[:tag_id]
      @selected_collection = Tag.find(params[:tag_id]).scraps & get_all_user_scraps
      @selected_collection.paginate(:page => params[:page], :per_page => 9) 
      render("collection/filter_home.js")
    elsif params[:category_id]
      @selected_collection = Category.find(params[:category_id]).scraps & get_all_user_scraps
      @selected_collection.paginate(:page => params[:page], :per_page => 9) 
      render("collection/filter_home.js")
    end
  end

  def search
    if params[:user_specific] == 'true'
      @selected_collection = Scrap.private_search(params[:query], get_session_user.id).paginate(:page => params[:page], :per_page => 9)
      @user = get_session_user
      @categories = get_all_user_categories
      @vb = get_session_user.vision_boards
      render("collection/view_collection")
    else
      @collection = Scrap.public_search(params[:query]).paginate(:page => params[:page], :per_page => 9)
      @categories = Category.all
      @cities = City.all.collect(&:city)
      flash.now[:info] = "sorry, nothing found" if @collection.empty?
      render("collection/browse_collection")
    end
  end

  def advanced_category_filter
    @collection = []
    price_range = calculate_price(params[:price_range])
    all = find_scraps_by_city_and_category(params[:city], params[:category_id])    
    for scrap in all
      @collection << scrap if (price_range[0]..price_range[1]).include?(scrap.product_listings[0].price)
    end
    @collection = @collection.paginate(:page => params[:page], :per_page => 9)
    @categories = Category.all
    @cities = City.all.collect(&:city)
    flash.now[:info] = "sorry, nothing found" if @collection.empty?
    render("collection/browse_collection")    
  end

end
