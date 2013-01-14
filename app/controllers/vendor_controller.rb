class VendorController < ApplicationController
  require 'will_paginate/array'

  layout 'standard'
  before_filter :confirm_vendor_authorization, :except => [:vendor_detail, :advanced_filter_vendor, :browse_vendors]
  before_filter :confirm_test_authorization

  def vendor_signup
    @vendor = Vendor.new
    @cities = City.all.collect(&:city)
    render('vendor_form')
  end

  def vendor_profile
    @vendor = get_session_user.vendor
  end

  def vendor_detail
    @vendor = Vendor.find(params[:vendor_id])
    @vendor_items = @vendor.user.owned_scraps
    render( :template => 'vendor/vendor_detail', :layout => "vendor_detail")
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

  def edit
    @vendor = get_session_user.vendor
    @cities = City.all.collect(&:city)
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
    @selected_collection = Scrap.owned_scraps(get_session_user.id).paginate(:page => params[:page], :per_page => 10)
  end

  def dashboard
    @total_number_of_shares = Scrap.sum(:number_of_shares)
  end

  def browse_vendors
    @categories = Category.all
    @cities = City.all.collect(&:city)
    if params[:business_type] || params[:city]
      @vendors = Vendor.where("business_type LIKE ? AND metro_area LIKE ?", params[:business_type], params[:city]).all.paginate(:page => params[:page], :per_page => 9) 
    else
      @vendors = Vendor.all.paginate(:page => params[:page], :per_page => 9) 
    end
    flash.now[:info] = "sorry, nothing found" if @vendors.empty?
  end

  def advanced_filter_vendor
    @vendors = []
    price_range = calculate_price(params[:price_range])
    if params[:business_type] || params[:city]
      long_vendors = Vendor.where("business_type LIKE ? AND metro_area LIKE ?", params[:business_type], params[:city]).all.paginate(:page => params[:page], :per_page => 9) 
    else
      long_vendors = Vendor.all.paginate(:page => params[:page], :per_page => 9) 
    end
    if long_vendors
      long_vendors.each do |vendor|
        @vendors << vendor if (price_range[0]..price_range[1]).include?(vendor.price)
      end
    end
    @vendors =  @vendors.paginate(:page => params[:page], :per_page => 9)
    @categories = Category.all
    @cities = City.all.collect(&:city)
    flash.now[:info] = "sorry, nothing found" if @vendors.empty?
    render("vendor/browse_vendors")    
  end


end
