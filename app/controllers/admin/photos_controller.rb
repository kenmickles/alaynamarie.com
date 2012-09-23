class Admin::PhotosController < Admin::AdminController
  after_filter :expire_cache, :only => [:create, :update, :destroy]
  
  private
  
  def after_save_redirect_path
    edit_admin_book_path(@photo.book_id)
  end
  
  def expire_cache
    expire_action "show_book_#{@photo.book_id}"
  end
end