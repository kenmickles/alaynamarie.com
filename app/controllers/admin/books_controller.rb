class Admin::BooksController < Admin::AdminController
  after_filter :set_photo_weights, :only => [:update]
  
  def set_photo_weights
    params[:photo_ids].to_s.split(',').each_with_index do |id, i|
      Photo.find(id).update_attribute(:weight, i)
    end
  end
end