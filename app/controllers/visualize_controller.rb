class VisualizeController < ApplicationController
    
  def index
  @images = get_all_user_scraps.uniq
  end
  
end
