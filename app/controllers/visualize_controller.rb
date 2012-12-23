class VisualizeController < ApplicationController
  before_filter :confirm_logged_in, :except => []
    
  def index
  @images = get_all_user_scraps.uniq
  end
  
end
