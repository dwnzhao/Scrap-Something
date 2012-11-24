class VendorController < ApplicationController
  require 'will_paginate/array'

  layout 'vendor'
  before_filter :confirm_vendor_authorization, :except => [:vendor_filter]


  def vendor_signup
    @vendor = Vendor.new
    @cities = City.all
    render('vendor_form')
  end

  def create_vendor
    @vendor = Vendor.new(params[:vendor])
    if @vendor.save
      get_session_user.vendor = @vendor
      redirect_to(:action => "vendor_profile", :controller => "vendor")
    else
      render('vendor_form')
    end
  end
  
  def vendor_profile
    @vendor = get_session_user.vendor
    if @vendor.blank?
      redirect_to(:action => 'vendor_signup', :controller => 'vendor')
    end
  end

  def edit
    @vendor = get_session_user.vendor
    @cities = City.all
  end

  def update
    vendor = get_session_user.vendor
    if vendor.update_attributes(params[:vendor])
      flash[:notice] = "Updated company profile!"
      redirect_to(:action => "vendor_profile")
    else
      render('edit')
    end
  end

  def view_items
    @selected_collection = get_all_user_scraps.paginate(:page => params[:page], :per_page => 10)
  end

  def dashboard
    @total_number_of_shares = Scrap.sum(:number_of_shares)
  end
  
  def vendor_filter
    @categories = Category.all
    @cities = City.all
    @vendors = Vendor.where("business_type LIKE ? AND metro_area LIKE ?", params[:business_type], params[:city])
    render("vendor/vendor_filter.js")
    
  end

end
