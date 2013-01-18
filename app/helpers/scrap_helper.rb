module ScrapHelper
  
  def process_favorite(scrap)
    if scrap_favorite?(scrap)
      return link_to(image_tag('/assets/heart-full.png'), {:action => 'defavor', :controller => 'share', :scrap_id => scrap.id}, {:title => "defavor", :target => "_parent"})
    else
      return link_to(image_tag('/assets/heart-empty.png'), {:action => 'favor', :controller => 'share', :scrap_id => scrap.id}, {:title => "mark as favorite", :target => "_parent"})
    end
  end
  
end
