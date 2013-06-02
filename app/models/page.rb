class Page < ActiveRecord::Base
  validates_presence_of :title, :body, :url
  validates_uniqueness_of :url

  before_validation :set_url

  private

  def set_url
    self.url = title.parameterize if title.present? and url.blank?
  end
end