class VisualizeController < ApplicationController
  before_filter :confirm_logged_in, :except => []
  require 'base64'
  layout 'standard'

  def index
    @images = get_all_user_scraps.uniq
  end

  def save
    vb = VisionBoard.new()
    File.open('test.png',"wb") do |file|
      file.binmode
      file.write(Base64.decode64(params[:img_url]))
      vb.photo = file
      file.close
    end
    vb.name = params[:vb_name]
    vb.save
    get_session_user.vision_boards << vb
    render :js => "window.location = '/collection/view_collection'"
  end
  
  def delete
    VisionBoard.find(params[:vb_id]).destroy
    flash[:notice] = "Vision Board deleted..."
    redirect_to(:action => 'view_collection', :controller => 'collection')
    
  end

end
