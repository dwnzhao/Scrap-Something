class AccessController < ApplicationController
  layout "access"
  respond_to :html, :js

  before_filter :confirm_logged_in, :except => [:index, :signup, :login, 
    :logout, :create, :authenticate, :landing_page]

    def index
      if (session[:user_id] && confirm_vendor_authorization)
        redirect_to(:action => "vendor_profile", :controller => "vendor") 
      elsif (session[:user_id])
        redirect_to(:action => "view_collection", :controller => "collection") 
      else
        redirect_to(:action => "browse_collection", :controller => "collection", )
      end
    end

    def signup
      if (session[:user_id])
        flash[:warning] = "... please first log out ..."
        redirect_to(:action => "profile")
      else 
        @user = User.new
        @cities = City.all
      end
    end

    def login    
      redirect_to(:action => "index") if (session[:user_id])
    end

    def logout      
      session[:user_id] = nil
      get_session_user(false)
      redirect_to(:action => "index")
    end

    def create
      @user = User.new(params[:user])
      if @user.save
        session[:user_id] = @user.id
        if (@user.user_level > 1)
          redirect_to(:action => "vendor_signup", :controller => "vendor")
        else
          render("upload_profile_pic")
        end
      else
        @cities = City.all
        render("signup")
      end
    end

    def update_profile_pic
      user = get_session_user
      user.update_attributes(params[:user])
      flash[:notice] = "Profile picture saved!"
      redirect_to(:action => "profile")
    end

    def edit
      @user = get_session_user
      @cities = City.all
      
    end

    def update
      @user = get_session_user
      if @user.update_attributes(params[:user])
        flash[:notice] = "Updated profile!"
        if (confirm_vendor_authorization)
          redirect_to(:action => "vendor_profile", :controller => "vendor")
        else
          redirect_to(:action => "profile")
        end
      else
        render("edit")
      end
    end

    def profile
      if (confirm_vendor_authorization)
        redirect_to(:action => "vendor_profile", :controller => "vendor")
      else      
        @user = get_session_user
      end
    end

    def delete
      get_session_user.destroy
      get_session_user(false)
      session[:user_id] = nil
      flash[:notice] = "Deleted profile..."
      redirect_to(:action => "index")
    end

    def authenticate
      authorized_user = User.authenticate(params[:email], params[:password])
      if authorized_user
        session[:user_id] = authorized_user.id
        redirect_to(:action => "index")
      else
        flash[:warning] = "Invalid email / password combination"
        render("login")
      end
    end

  end