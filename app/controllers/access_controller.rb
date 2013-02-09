class AccessController < ApplicationController
  layout "standard"
  respond_to :html, :js

  before_filter :confirm_test_authorization, :except => [:tester_access]

  def index
    if vendor_authorization?
      redirect_to(:action => "view_items", :controller => "vendor")
    elsif (session[:user_id])
      redirect_to(:action => "view_collection", :controller => "collection") 
    else
      redirect_to(:action => "browse_collection", :controller => "collection", )
    end
  end

  def tester_access
    if (params[:username] == 'LBBTester' && params[:password] == 'ScrapSomething')
      session[:test_id] = true
      redirect_to(:action => "browse_collection", :controller => "collection", )  
    elsif
      (params[:username] == 'DawnDemo' && params[:password] == 'ScrapSomething')
        session[:test_id] = true
        redirect_to(:action => "landing_page", :controller => "collection", )  
      
    else
      flash[:warning] = "wrong log in information"
      render( :layout => false, :action => 'test_access')
    end
  end

  def test_access
    render( :layout => false)
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