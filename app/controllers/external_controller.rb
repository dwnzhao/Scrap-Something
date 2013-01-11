class ExternalController < ApplicationController
  require "open-uri"

  def add_external_image
    external_image = open params[:img_url]
    scrap = Scrap.new()
    scrap.creator_id = session[:user_id]
    scrap.name = params[:name]
    scrap.source = params[:name]
    scrap.description = 'added from ' + params[:name]
    scrap.photo = external_image
    scrap.save
    get_session_user.collections.external.scraps << scrap
    if !scrap.new_record?
      redirect_to(:action => 'view_collection', :controller => 'collection')
    else
      render('add_external_image')
    end
  end
  
  def save_link_scrap
    external_image = open params[:img_url]
    @scrap = Scrap.new(params[:scrap])
    @scrap.photo = external_image
    @scrap.creator_id = session[:user_id]
    Category.find_by_name(params[:category]).scraps << @scrap
    if !@scrap.new_record?
      process_keywords(params[:keywords], @scrap) if params[:keywords]
      get_session_user.collections.external.scraps << @scrap
      flash[:notice] = "Clip added!"
      if vendor_authorization?
        redirect_to(:action => "add_listing", :controller => 'product_listing', :scrap_id => @scrap.id) 
        return
      end
      redirect_to(:action => 'view_collection', :controller => 'collection')
      return
    else
      @categories = Category.all.collect(&:name)
      render('scrap/link_scrap', :layout => 'access')
    end
  end

end