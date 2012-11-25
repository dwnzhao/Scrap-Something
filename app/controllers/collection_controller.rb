class CollectionController < ApplicationController
  require 'will_paginate/array'

  layout 'view_collection'
  respond_to :html, :js

  before_filter :confirm_logged_in, :except => [:browse_collection, :search, :category_filter]

  def index
    redirect_to(:action => 'browse_collection')
  end

  def view_collection
    if (confirm_vendor_authorization)
      redirect_to(:action => "view_items", :controller => 'vendor')
    else
      @selected_collection = get_all_user_scraps.uniq
      @user = get_session_user
      @categories = get_all_user_categories
    end
  end

  def browse_collection
    @categories = Category.all
    @cities = City.all
    @collection = (Scrap.public_scraps - get_all_user_scraps).paginate(:page => params[:page], :per_page => 10) if (session[:user_id])
    @collection = Scrap.where(:visibility => true).paginate(:page => params[:page], :per_page => 10)
  end

  def search
    if (params[:user_specific] == 'true')
      @selected_collection = Scrap.search(params[:search_home]) & get_all_user_scraps
      render("collection/filter_home.js")
    else
      @selected_collection = Scrap.search(params[:search_explore])
      render("collection/filter_explore.js")
    end
  end

  def category_filter
    if(params[:user_specific])
      @selected_collection = Category.find(params[:id]).scraps & get_all_user_scraps
      render("collection/filter_home.js")
    else
      @selected_collection = Category.find(params[:id]).scraps
      render("collection/filter_explore.js")
    end
  end


end
