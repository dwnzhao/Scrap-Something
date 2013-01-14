class TabController < ApplicationController
  before_filter :confirm_logged_in, :except => [:view_scrap_detail, :switch_image]

  def get_tabs
    user = get_session_user
    @tabs = user.tabs.to_json
    render json: @tabs
  end

  def create_tab
    begin
      user = get_session_user
      tab = Tab.new()
      tab.name = params[:name]
      user.tabs << tab
    rescue ActiveResource::MethodNotAllowed
      flash[:warning] = "cannot add any more tabs (max is 7)"
      render :js => "<script>window.location = '/collection/view_collection'</script>"
    else
      render :nothing => true
    end
  end

  def tab_filter
    if (params[:id].blank?)
      @selected_collection = get_all_user_scraps.uniq
    else
      @selected_collection = Tab.find(params[:id]).scraps
    end
    render("collection/filter_home", :format => [:js])
  end

  def include_in_tab
    tab = Tab.find(params[:tab_id])
    scrap = Scrap.find(params[:scrap_id])
    if (!get_bookmark_status(scrap) && !get_user_authorization(scrap))
      user = get_session_user
      user.collections.find_by_name('bookmarked').scraps << scrap
      scrap.update_attribute(:number_of_shares, scrap.number_of_shares + 1)
    end
    tab.scraps << scrap
    flash[:notice] = "Saved to tab!"
    redirect_to(:controller => 'collection', :action => 'view_collection')
  end

  def remove_from_tab
    tab = Tab.find(params[:tab_id])
    scrap = Scrap.find(params[:scrap_id])
    if (get_bookmark_status(scrap))
      get_session_user.collections.bookmarked.scraps.destroy(scrap)
    end
    tab.scraps.destroy(scrap)
    flash[:notice] = "Deleted from tab!"
    redirect_to(:controller => 'collection', :action => 'view_collection')
  end

  def delete_tab
    if (params[:tab_id].blank?)
      flash[:warning] = "can't delete this tab!"
      redirect_to(:controller => 'collection', :action => 'view_collection')
    else
      Tab.find(params[:tab_id]).destroy
      flash[:notice] = "Tab deleted!"
      redirect_to(:controller => 'collection', :action => 'view_collection')   
    end
  end


end
