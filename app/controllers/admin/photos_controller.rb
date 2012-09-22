class Admin::PhotosController < Admin::AdminController
  protected
  
  def after_save_redirect_path
    edit_admin_book_path(@photo.book_id)
  end
end