class ExternalController < ApplicationController
  require "open-uri"

  def add_external_image
    external_image = open params[:img_url]
    scrap = Scrap.where(:name => params[:name])[0]
    if (scrap.nil?)
      scrap = Scrap.new()
      scrap.creator_id = session[:user_id]
      scrap.name = params[:name]
      scrap.photo = external_image
      scrap.save
    else 
      n = Image.new()
      n.image = external_image
      scrap.images << n      
    end
    if !scrap.new_record?
      flash[:notice] = "... scrap added ..."
      redirect_to(:action => 'view_collection', :controller => 'collection')
    else
      flash[:notice] = "... wrong ..."
      render('add_external_image')
    end

  end

end