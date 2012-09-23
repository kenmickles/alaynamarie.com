class Admin::BooksController < Admin::AdminController
  after_filter :set_photo_weights, :only => [:update]
  after_filter :expire_cache, :only => [:update]
  
  private
  
  def set_photo_weights
    params[:photo_ids].to_s.split(',').each_with_index do |id, i|
      Photo.find(id).update_attribute(:weight, i)
    end
  end
  
  def expire_cache
    expire_action "show_book_#{@book.id}"
  end
end