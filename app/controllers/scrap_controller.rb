class ScrapController < ApplicationController
  layout 'view_collection'
  before_filter :confirm_logged_in, :except => [:view_scrap_detail, :switch_image, :switch_scrap]

  def upload_scrap
    @scrap = Scrap.new
    @categories = Category.all
  end

  def save_upload_scrap
    @scrap = Scrap.new(params[:scrap])
    @scrap.creator_id = session[:user_id]
    @scrap.save
    if !@scrap.new_record?
      process_categories(params[:categories], @scrap)
      get_session_user.collections.uploaded.scraps << @scrap
      flash[:notice] = "Added Scrap!"
      if vendor_authorization?
        redirect_to(:action => "add_listing", :controller => 'product_listing', :scrap_id => @scrap.id) 
        return
      end
      redirect_to(:action => 'view_collection', :controller => 'collection')
      return
    else
      @categories = Category.all
      render('upload_scrap')
    end
  end

  def edit
    @scrap = Scrap.find(params[:scrap_id])
    if (get_user_authorization(@scrap))
      @categories = Category.all
      @images = @scrap.images
    else
      redirect_to(:action => 'view_collection', :controller => 'collection')
    end
  end

  def view_scrap_detail
    @scrap = Scrap.find(params[:scrap_id])
    user = User.find(@scrap.creator_id)
    @categories = get_category_names(@scrap)
    @images = @scrap.images
    unless user.vendor.blank?
      @creator_name = user.vendor.company  
      @phone = user.vendor.phone
    end
    @listings = get_listing(params[:scrap_id])
    if (session[:user_id] && !vendor_authorization?)
      @tabs = get_session_user.tabs.uniq
      @remove_tabs = @scrap.tabs.uniq
    end 
    @vendor_items = user.owned_scraps - Array(@scrap)
    render :template => 'scrap/view_scrap_detail', :layout => 'scrap_detail'
  end

  def update_scrap
    @scrap = Scrap.find(params[:scrap_id])
    if @scrap.update_attributes(params[:scrap])
      process_categories(params[:categories], @scrap)
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

  def switch_image
    @image = Image.find(params[:image_id])
    @scrap = @image.scrap
    @categories = get_category_names(@scrap)
    @images = @scrap.images - @image.to_a
    render :template => 'scrap/view_scrap_detail', :layout => 'scrap_detail'
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
