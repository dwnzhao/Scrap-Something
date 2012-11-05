class ProductListingController < ApplicationController
  layout 'view_collection' 
  helper :all 
  
  def add_listing
    user = get_session_user
    if(user.user_level >= 3)
      @listing = ProductListing.new
      @scrap_id = params[:scrap_id]
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
  

  
end
