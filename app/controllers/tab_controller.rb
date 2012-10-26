class TabController < ApplicationController

  def get_tabs
    user = get_session_user
    @tabs = user.tabs.to_json
    render json: @tabs
  end

  def create_tab
    user = get_session_user
    tab = Tab.new()
    tab.name = params[:name]
    user.tabs << tab
    render :nothing => true
  end
  
  def tab_filter
    if (params[:id].blank?)
      @selected_collection = get_all_user_scraps
    else
      @selected_collection = Tab.find(params[:id]).scraps
    end
      render("collection/filter.js")
  end
  

end
