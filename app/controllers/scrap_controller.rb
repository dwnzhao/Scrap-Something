class ScrapController < ApplicationController
  layout 'view_collection'
  before_filter :confirm_logged_in, :except => [:view_scrap_detail, :switch_image]

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
      collection = get_session_user.collections.find_by_name('uploaded')
      collection.scraps << @scrap
      collection.save
      redirect_to(:action => 'view_collection', :controller => 'collection')
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
    @categories = get_category_names(@scrap)
    @images = @scrap.images
    @creator_name = User.find(@scrap.creator_id).email  
    if !@scrap.product_listings.blank? 
      @listings = get_listing(params[:id])
    else
      @listings = []
    end
    render :template => 'scrap/view_scrap_detail', :layout => 'scrap_detail'

  end

  def update_scrap
    @scrap = Scrap.find(params[:id])
    checked_categories = get_categories_from(params[:categories])
    remove_categories = Category.all - checked_categories
    if @scrap.update_attributes(params[:scrap])
      checked_categories.each {|cat| @scrap.categories << cat if !@scrap.categories.include?(cat)}
      remove_categories.each {|cat| @scrap.categories.destroy(cat) if @scrap.categories.include?(cat)}
      flash[:notice] = "... edits saved ..."
      redirect_to(:action => 'view_collection', :controller => 'collection')
    else
      @categories = Category.all
      render('edit_scrap')
    end
  end


  def destroy_scrap
    Scrap.find(params[:scrap_id]).destroy
    flash[:notice] = "... scrap deleted ..."
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
      flash[:notice] = "... image added ..."
      redirect_to(:action => 'view_collection', :controller => 'collection')
    else
      render('add_image_to_scrap')
    end
  end

  def destroy_image_to_scrap
    image = Image.find(params[:id]).destroy
    flash[:notice] = "... image deleted ..."
    redirect_to(:action => 'view_collection', :controller => 'collection')
  end

  def switch_image
    @image = Image.find(params[:id])
    @scrap = @image.scrap
    @categories = get_category_names(@scrap)
    array = []
    array << @image
    @images = @scrap.images - array
    @creator_name = User.find(@scrap.creator_id).email
    render :template => 'scrap/view_scrap_detail', :layout => 'scrap_detail'
  end
  
  def get_listing(id)
    scrap = Scrap.find(id)
    return scrap.product_listings
  end
  


end
