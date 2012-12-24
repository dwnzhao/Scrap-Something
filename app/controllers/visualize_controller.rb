class VisualizeController < ApplicationController
  before_filter :confirm_logged_in, :except => []
  require 'base64'


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
    vb.save
    get_session_user.vision_boards << vb
    render :js => "window.location = '/collection/view_collection'"
  end

end
