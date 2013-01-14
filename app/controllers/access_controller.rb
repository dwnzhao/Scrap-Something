class AccessController < ApplicationController
  layout "standard"
  respond_to :html, :js

    def index
      if vendor_authorization?
        redirect_to(:action => "view_items", :controller => "vendor")
      elsif (session[:user_id])
        redirect_to(:action => "view_collection", :controller => "collection") 
      else
        redirect_to(:action => "browse_collection", :controller => "collection", )
      end
    end
  
    def signup
      if (session[:user_id])
        flash[:warning] = "... please first log out ..."
        redirect_to(:action => "view_collection", :controller => "collection")
      else 
        @user = User.new
        @cities = City.all.collect(&:city)
      end      
    end

    def login    
      redirect_to(:action => "index") if (session[:user_id])
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
        render("signup")
      end
    end

    def logout      
      session[:user_id] = nil
      get_session_user(false)
      redirect_to('https://docs.google.com/spreadsheet/embeddedform?formkey=dE00T21hQkpXTGRKZlZiSWl1UERyYmc6MQ')
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