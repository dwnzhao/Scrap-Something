class UserController < ApplicationController
  before_filter :confirm_logged_in, :except => [:create]
  before_filter :confirm_test_authorization
  layout "standard"

  def instructed
    get_session_user.update_attribute(:instructed, true)
    redirect_to(:action => "view_collection", :controller => "collection") 
  end

  def reinstruct
    get_session_user.update_attribute(:instructed, false)
    redirect_to(:action => "view_collection", :controller => "collection") 
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      if (@user.user_level > 1)
        redirect_to(:action => "vendor_signup", :controller => "vendor")
      else
        redirect_to(:action => "view_collection", :controller => "collection")
      end
    else
      @cities = City.all.collect(&:city)
      render("access/signup")
    end
  end
  
  def edit
    @user = get_session_user
    @cities = City.all.collect(&:city)   
  end

  def update
    @user = get_session_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Updated profile!"
      redirect_to(:action => "vendor_profile", :controller => "vendor") if vendor_authorization?
      redirect_to(:action => "profile")
    else
      render("edit")
    end
  end

  def profile
    if vendor_authorization?
      @vendor = get_session_user.vendor
      render(:template => 'vendor/vendor_signup', :layout => 'vendor') if @vendor.blank?
      render(:template => 'vendor/vendor_profile', :layout => 'vendor')
    else
      @user = get_session_user
    end
  end

  def delete
    get_session_user.destroy
    get_session_user(false)
    session[:user_id] = nil
    flash[:notice] = "Deleted profile..."
    redirect_to(:controller => "collection")
  end

end
