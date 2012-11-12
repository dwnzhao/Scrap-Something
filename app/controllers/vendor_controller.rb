class VendorController < ApplicationController

  layout 'vendor'
  before_filter :confirm_vendor_authorization, :except => []

  def vendor_profile
    @vendor = get_session_user.vendor
    if @vendor.blank?
      redirect_to(:action => 'vendor_signup', :controller => 'access')
    end
  end

  def edit
    @vendor = get_session_user.vendor
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
    @selected_collection = get_all_user_scraps
  end

end
