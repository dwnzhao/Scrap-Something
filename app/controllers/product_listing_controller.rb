class ProductListingController < ApplicationController
  layout 'view_collection' 
  before_filter :confirm_vendor_authorization, :except => []

  def add_listing
    user = get_session_user
    if(user.user_level >= 3)
      @listing = ProductListing.new
      @scrap_id = params[:scrap_id]
      @cities = City.all.collect(&:city)
    else
      flash[:warning] = "... you must be a vendor to list your item ..."
      redirect_to(:action => 'view_collection', :controller => 'collection', :id => params[:id])
    end 
  end

  def save_listing
    listing = ProductListing.new(params[:product_listing])
    listing.vendor_id = session[:user_id]
    listing.scrap_id = params[:id]
    listing.save
    if !listing.new_record?
      flash[:notice] = "... listing added ..."
      redirect_to(:action => 'view_collection', :controller => 'collection')
    else
      render('add_listing')
    end
  end

  def edit_listing
    user = get_session_user
    if(user.user_level >= 3)
      @product_listing = ProductListing.find(params[:listing_id])
      @cities = City.all.collect(&:city)
    else
      flash[:warning] = "... you must be a vendor to list your item ..."
      redirect_to(:action => 'view_collection', :controller => 'collection', :id => params[:id])
    end 
  end

  def update_listing
    listing = ProductListing.find(params[:listing_id])
    if listing.update_attributes(params[:product_listing])
      flash[:notice] = "Updated listing!"
      redirect_to(:action => "view_items", :controller => "vendor")
    else
      render("edit_listing")
    end
  end

  def delete_listing
    ProductListing.find(params[:listing_id]).destroy
    flash[:notice] = "Listing deleted!"
    redirect_to(:controller => 'vendor', :action => 'view_items')   
    
  end


end
