require 'spec_helper'

describe Book do
  it "has a valid factory" do
    build(:book).should be_valid
  end

  it "has many photos" do
    book = create(:book)
    2.times { create(:photo, :book => book) }
    book.reload
    book.photos.first.should be_a_kind_of Photo
    book.photos.length.should eq 2
  end
end