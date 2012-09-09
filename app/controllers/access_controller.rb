class AccessController < ApplicationController
  layout 'access'
  respond_to :html, :js

  before_filter :confirm_logged_in, :except => [:index, :signup, :login, 
    :logout, :create_user, :authenticate]

    def index
      if (session[:user_id])
        redirect_to(:action => 'view_collection', :controller => 'collection')
      else 
        render('landing_page')
      end
    end

    def signup
      if (session[:user_id])
        flash[:notice] = "please first log out as #{session[:username]}"
        redirect_to(:action => 'index')
      else 
        @user = User.new
      end
    end

    def login    
      if (session[:user_id])
        redirect_to(:action => 'index')
      end
    end

    def logout      
      session[:user_id] = nil
      session[:username] = nil
      flash[:notice] = "You are now logged out."
      redirect_to(:action => 'index')
    end

    def create_user
      @user = User.new(params[:user])
      if @user.save
        session[:user_id] = @user.id
        session[:username] = @user.user_name
        render('upload_profile_pic')
      else
        render('signup')
      end
    end

    def update_profile_pic
      @user = get_session_user
      @user.attributes = params[:user]
      if @user.save
        flash[:notice] = "profile created."
        redirect_to(:action => 'index')
      else
        render('update_profile_pic')
      end
    end

    def edit_profile
      @user = get_session_user
    end

    def update_user
      @user = get_session_user
      if @user.update_attributes(params[:user])
        flash[:notice] = "... profile updated ..."
        redirect_to(:action => 'profile')
      else
        render('edit_profile')
      end
    end

    def profile
      @user = get_session_user
    end


    def delete_profile
      @user = get_session_user
    end 

    def destroy_profile
      User.get_session_user.destroy
      session[:user_id] = nil
      session[:username] = nil
      flash[:notice] = "... profile deleted ..."
      redirect_to(:action => 'index')
    end
  end


  private #--------------------------------------------------------------

  def authenticate
    @authorized_user = User.authenticate(params[:username], params[:password])
    if @authorized_user
      session[:user_id] = @authorized_user.id
      session[:username] = @authorized_user.user_name
      flash[:notice] = "You are now logged in."
      redirect_to(:action => 'index')
    else
      flash[:notice] = "Invalid username / password combination"
      render('login')
    end
  end