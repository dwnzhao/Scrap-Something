class ScrapController < ApplicationController
  layout 'scrap_detail'
  before_filter :confirm_logged_in, :except => [:view_scrap_detail, :switch_image, :switch_scrap]

  def upload_scrap
    @scrap = Scrap.new
    @categories = Category.all
  end

  def save_upload_scrap
    @scrap = Scrap.new(params[:scrap])
    @scrap.creator_id = session[:user_id]
    @scrap.save
    checked_categories = get_categories_from(params[:categories])
    remove_categories = Category.all - checked_categories
    if !@scrap.new_record?
      checked_categories.each {|cat| @scrap.categories << cat if !@scrap.categories.include?(cat)}
      remove_categories.each {|cat| @scrap.categories.destroy(cat) if @scrap.categories.include?(cat)}
      get_session_user.collections.uploaded.scraps << @scrap
      flash[:notice] = "Added Scrap!"
      if (confirm_vendor_authorization)
        redirect_to(:action => "add_listing", :controller => 'product_listing', :scrap_id => @scrap)
      else
        redirect_to(:action => 'view_collection', :controller => 'collection')
      end
    else
      @categories = Category.all
      render('upload_scrap')
    end
  end

  def edit
    @scrap = Scrap.find(params[:id])
    @categories = Category.all
    @images = @scrap.images
  end

  def view_scrap_detail
    @scrap = Scrap.find(params[:id])
    user = User.find(@scrap.creator_id)
    @categories = get_category_names(@scrap)
    @images = @scrap.images
    unless user.vendor.blank?
      @creator_name = user.vendor.company  
      @phone = user.vendor.phone
    end
    @listings = get_listing(params[:id]).compact
    if (session[:user_id] && !confirm_vendor_authorization)
      @tabs = get_session_user.tabs.uniq
      @remove_tabs = @scrap.tabs.uniq
    end 
    @vendor_items = user.owned_scraps - Array(@scrap)
    render :template => 'scrap/view_scrap_detail', :layout => 'scrap_detail'
  end

  def update_scrap
    @scrap = Scrap.find(params[:id])
    checked_categories = get_categories_from(params[:categories])
    remove_categories = Category.all - checked_categories
    if @scrap.update_attributes(params[:scrap])
      checked_categories.each {|cat| @scrap.categories << cat if !@scrap.categories.include?(cat)}
      remove_categories.each {|cat| @scrap.categories.destroy(cat) if @scrap.categories.include?(cat)}
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
    @scrap_id = params[:id]
  end

  def save_image_to_scrap
    image = Image.new(params[:image])
    scrap = Scrap.find(params[:id])
    if image.save
      scrap.images << image
      flash[:notice] = "Image added!"
      redirect_to(:action => 'view_collection', :controller => 'collection')
    else
      render('add_image_to_scrap')
    end
  end

  def destroy_image_to_scrap
    image = Image.find(params[:id]).destroy
    flash[:notice] = "Image deleted ..."
    redirect_to(:action => 'view_collection', :controller => 'collection')
  end

  def switch_image
    @image = Image.find(params[:id])
    @scrap = @image.scrap
    @categories = get_category_names(@scrap)
    array = []
    array << @image
    @images = @scrap.images - array
    
    render :template => 'scrap/view_scrap_detail', :layout => 'scrap_detail'
  end

  def switch_scrap
    @scrap = Scrap.find(params[:id])
    user = User.find(@scrap.creator_id)
    @categories = get_category_names(@scrap)
    @creator_name = User.find(@scrap.creator_id).email
    @images = @scrap.images
    unless user.vendor.blank?
      @creator_name = user.vendor.company  
      @phone = user.vendor.phone
    end
    @listings = get_listing(params[:id]).compact
    if (session[:user_id] && !confirm_vendor_authorization)
      @tabs = get_session_user.tabs.uniq
      @remove_tabs = @scrap.tabs.uniq
    end 
    
    
    @vendor_items = user.owned_scraps - Array(@scrap)
    render :template => 'scrap/view_scrap_detail', :layout => 'scrap_detail'
  end

  def get_listing(id)
    scrap = Scrap.find(id)
    return scrap.product_listings
  end



end
