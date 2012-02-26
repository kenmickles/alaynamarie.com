class Photo < ActiveRecord::Base
  belongs_to :book
  
  # paperclip
  has_attached_file :image,
    :storage => :s3,
    :path => "/:id/:style/:filename",
    :default_url => "http://dummyimage.com/830x553/000/fff&text=404",
    :s3_credentials => {
      :access_key_id => ENV['S3_KEY'],
      :secret_access_key => ENV['S3_SECRET']
    },
    :bucket => ENV['S3_BUCKET']  ,
    :styles => {:large => "830x830>", :medium => "560x560>", :thumb => "64x64#"}
   
  def prev
    book.photos.each_with_index do |photo, i|
      if photo.id == id
        @prev_photo = book.photos[i-1].present? ? book.photos[i-1] : book.photos.last
        break
      end
    end
    
    @prev_photo
  end
  
  def next
    book.photos.each_with_index do |photo, i|
      if photo.id == id
        @next_photo = book.photos[i+1].present? ? book.photos[i+1] : book.photos.last
        break
      end
    end
    
    @next_photo
  end
end