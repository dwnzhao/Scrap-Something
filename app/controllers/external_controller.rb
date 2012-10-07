class ExternalController < ApplicationController
  require "open-uri"

  def add_external_image
    external_image = open params[:img_url]
    scrap = Scrap.where(:name => params[:name], :creator_id => session[:user_id])[0]
    if (scrap.nil?)
      scrap = Scrap.new()
      scrap.creator_id = session[:user_id]
      scrap.name = params[:name]
      scrap.description = 'added from ' + params[:name]
      scrap.photo = external_image
      scrap.save
      get_session_user.collections.find_by_name('external').scraps << scrap
    else 
      n = Image.new()
      n.image = external_image
      scrap.images << n      
    end
    if !scrap.new_record?
      redirect_to(:action => 'view_collection', :controller => 'collection')
    else
      render('add_external_image')
    end

  end

end