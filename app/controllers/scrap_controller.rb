class ScrapController < ApplicationController
  layout 'scrap_detail'
  before_filter :confirm_logged_in, :except => [:view_scrap_detail, :switch_image, :switch_scrap]
  respond_to :html, :js
  before_filter :confirm_test_authorization

  def upload_scrap
    @scrap = Scrap.new
    @categories = Category.all.collect(&:name)
    @tabs = get_session_user.tabs.uniq
    @from_url = params[:from_url]
    render(:layout => 'standard')
  end

  def view_scrap_detail
    @scrap = Scrap.find(params[:scrap_id])
    user = User.find(@scrap.creator_id)
    @categories = @scrap.category
    if (params[:image_id])
      @image = Image.find(params[:image_id])
    else
      @image = @scrap.photo
    end
    @icons = @scrap.images - Array(@image)
    @keywords = @scrap.keywords
    unless user.vendor.blank?
      @vendor = user.vendor  
      @vendor_items = Scrap.owned_scraps(@vendor.id) - Array(@scrap)
    end
    @listings = get_listing(params[:scrap_id])
    if (session[:user_id] && !vendor_authorization?)
      @tabs = get_session_user.tabs.uniq
      @remove_tabs = @scrap.tabs.uniq
    end 
  end

  def save_upload_scrap
    @scrap = Scrap.new(params[:scrap])
    @scrap.creator_id = session[:user_id]
    @scrap.save
    if !@scrap.new_record?
      Category.find_by_name(params[:category]).scraps << @scrap
      process_keywords(params[:keywords], @scrap) if params[:keywords]
      process_tags(params[:tags], @scrap) if params[:tags]
      process_tabs(params[:tabs], @scrap)
      get_session_user.collections.uploaded.scraps << @scrap
      flash[:notice] = "Clip added!"
      if vendor_authorization?
        redirect_to(:action => "add_listing", :controller => 'product_listing', :scrap_id => @scrap.id) 
        return
      end
      redirect_to(:action => 'view_collection', :controller => 'collection')
      return
    else
      @categories = Category.all.collect(&:name)
      @tabs = get_session_user.tabs.uniq
      render('upload_scrap', :layout => 'standard')
    end
  end

  def update_tabs
    scrap = Scrap.find(params[:scrap_id])
    process_tabs(params[:tabs], scrap)
    flash[:notice] = "Change saved!"
    redirect_to(:action => 'view_collection', :controller => 'collection')
  end

  def edit
    @scrap = Scrap.find(params[:scrap_id])
    if (get_user_authorization(@scrap))
      @categories = Category.all
      @images = @scrap.images
      @tabs = get_session_user.tabs
    else
      redirect_to(:action => 'view_collection', :controller => 'collection')
    end
  end

  def create_tab
    user = get_session_user
    tab = Tab.new()
    tab.name = params[:name]
    user.tabs << tab
    url = params[:url]
    begin 
      parse = url.split("=")
      scrap_id = parse.last.to_s.gsub(/[^0-9]/i, '')
    ensure
      @scrap = Scrap.find(scrap_id) if scrap_id
      @tabs = get_session_user.tabs.uniq
      render(:partial => 'scrap/partials/create_tab')
    end
  end

  def update_scrap
    @scrap = Scrap.find(params[:scrap_id])
    if @scrap.update_attributes(params[:scrap])
      process_categories(params[:categories], @scrap)
      process_tabs(params[:tabs], @scrap)
      flash[:notice] = "Edits saved!"
      redirect_to(:action => 'view_collection', :controller => 'collection')
    else
      @categories = Category.all
      render('edit_scrap')
    end
  end

  def destroy_scrap
    Scrap.find(params[:scrap_id]).destroy
    flash[:notice] = "Scrap deleted..."
    redirect_to(:action => 'view_collection', :controller => 'collection')
  end

  def add_img_to_scrap
    @image = Image.new
    @scrap_id = params[:scrap_id]
  end

  def save_image_to_scrap
    image = Image.new(params[:image])
    scrap = Scrap.find(params[:scrap_id])
    if image.save
      scrap.images << image
      flash[:notice] = "Image added!"
      redirect_to(:action => 'view_collection', :controller => 'collection')
    else
      render('add_image_to_scrap')
    end
  end

  def destroy_image_to_scrap
    image = Image.find(params[:image_id]).destroy
    flash[:notice] = "Image deleted ..."
    redirect_to(:action => 'view_collection', :controller => 'collection')
  end

  def make_invisible
    scrap = Scrap.find(params[:scrap_id])
    scrap.visibility = false
    scrap.save
    redirect_to(:action => 'view_collection', :controller => 'collection')
  end

  def make_visible
    scrap = Scrap.find(params[:scrap_id])
    scrap.visibility = true
    scrap.save
    redirect_to(:action => 'view_collection', :controller => 'collection')
  end


end
