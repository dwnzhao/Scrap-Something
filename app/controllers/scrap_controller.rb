class ScrapController < ApplicationController
  layout 'view_collection'

  def add_scrap
     @scrap = Scrap.new
     @categories = Category.all
   end

   def edit_scrap
     @scrap = Scrap.find(params[:id])
     @categories = Category.all
     @images = @scrap.images
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

   def save_add_scrap
     @scrap = Scrap.new(params[:scrap])
     @scrap.creator_id = session[:user_id]
     checked_categories = get_categories_from(params[:categories])
     remove_categories = Category.all - checked_categories
     @scrap.save
     if !@scrap.new_record?
       checked_categories.each {|cat| @scrap.categories << cat if !@scrap.categories.include?(cat)}
       remove_categories.each {|cat| @scrap.categories.destroy(cat) if @scrap.categories.include?(cat)}
       flash[:notice] = "... scrap added ..."
       redirect_to(:action => 'view_collection', :controller => 'collection')
     else
       @categories = Category.all
       render('add_scrap')
     end
   end

   def delete_scrap
     @scrap = Scrap.find(params[:id])
     
     respond_to do |format|
          format.html
          format.js {render :layout => false}
     end
   end
   
   def destroy_scrap
     Scrap.find(params[:id]).destroy
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
       redirect_to(:action => 'view_collection_detail', :controller => 'collection', :id => params[:id])
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
    render :template => 'collection/view_collection_detail', :layout => 'collection_detail'
  end
   

end
