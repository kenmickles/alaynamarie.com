class Book < ActiveRecord::Base
  has_many :photos, :order => "weight"
end