require 'spec_helper'

describe Photo do
  it "has a valid factory" do
    build(:photo).should be_valid
  end

  it "belongs to a book" do
    book = create(:book)
    create(:photo, :book => book).book.should eq book
  end

  it "is invalid without a book" do
    build(:photo, :book => nil).should_not be_valid
  end

  it "is invalid without an image" do
    build(:photo, :image => nil).should_not be_valid
  end

  it "sets weight to end of book by default" do
    book = create(:book)
    photos = []
    3.times { photos << create(:photo, :book => nil, :book_id => book.id) }
    photos[1].weight.should be > photos[0].weight
    photos[2].weight.should be > photos[1].weight
  end

  it "has an attached image" do
    create(:photo).image.url(:thumb).should match(/^http:\/\/s3\.amazonaws\.com\/alaynamarie-photos\//)
  end
end
