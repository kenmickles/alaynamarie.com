class Page < ActiveRecord::Base
  validates_presence_of :title, :body, :url
  validates_uniqueness_of :url
end