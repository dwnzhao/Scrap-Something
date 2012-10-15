class AccessController < ApplicationController
  layout 'access'
  respond_to :html, :js

  before_filter :confirm_logged_in, :except => [:index, :signup, :login, 
    :logout, :create, :authenticate, :landing_page]

    def index
      if (session[:user_id])
        redirect_to(:action => 'view_collection', :controller => 'collection') 
      else
        redirect_to(:action => 'browse_collection', :controller => 'collection', )
      end
    end

    def signup
      if (session[:user_id])
        @user = get_session_user
        flash[:notice] = "... please first log out ..."
        render(:template => 'access/profile')
      else 
        @user = User.new
      end
    end

    def login    
      redirect_to(:action => 'index') if (session[:user_id])
    end

    def logout      
      session[:user_id] = nil
      flash[:notice] = "... you are now logged out ..."
      redirect_to(:action => 'index')
    end

    def create
      @user = User.new(params[:user])
      if @user.save
        session[:user_id] = @user.id
        render('upload_profile_pic')
      else
        render('signup')
      end
    end

    def update_profile_pic
      user = get_session_user
      user.attributes = params[:user]
      flash[:notice] = "... profile created ..." if(user.save)
      redirect_to(:action => 'index')
    end

    def edit
      @user = get_session_user
    end

    def update
      @user = get_session_user
      if @user.update_attributes(params[:user])
        flash[:notice] = "... profile updated ..."
        redirect_to(:action => 'profile')
      else
        render('edit')
      end
    end

    def profile
      @user = get_session_user
    end

    def delete
      get_session_user.destroy
      session[:user_id] = nil
      flash[:notice] = "... profile deleted ..."
      redirect_to(:action => 'index')
    end

    def authenticate
      authorized_user = User.authenticate(params[:email], params[:password])
      if authorized_user
        session[:user_id] = authorized_user.id
        flash[:notice] = "... you are now logged in ..."
        redirect_to(:action => 'index')
      else
        flash[:notice] = "Invalid email / password combination"
        render('login')
      end
    end

  end