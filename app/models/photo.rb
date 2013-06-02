class Photo < ActiveRecord::Base
  belongs_to :book

  validates :book_id, :presence => true
  validates :image_file_name, :presence => true

  before_create :set_birth_weight

  # paperclip
  has_attached_file :image,
    :storage => :s3,
    # namespace the test environment
    :path => "#{'/' + Rails.env if Rails.env == 'test'}/:id/:style/:filename",
    :default_url => "http://dummyimage.com/830x553/000/fff&text=404",
    :s3_credentials => {
      :access_key_id => ENV['S3_KEY'],
      :secret_access_key => ENV['S3_SECRET']
    },
    :bucket => ENV['S3_BUCKET']  ,
    :styles => {:large => "830x830>", :medium => "560x560>", :thumb => "128x128#"}

  def set_birth_weight
    if book_id.present? and book.photos.present?
      self.weight = book.photos.last.weight + 1
    end
  end
end