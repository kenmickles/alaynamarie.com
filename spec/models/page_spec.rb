require 'spec_helper'

describe Page do
  it "has a valid factory" do
    build(:page).should be_valid
  end

  it "is invalid without a title" do
    build(:page, :title => nil).should_not be_valid
    build(:page, :title => "").should_not be_valid
  end

  it "builds a default URL from the title" do
    create(:page, :url => nil, :title => "Moose Soup").url.should eq "moose-soup"
  end

  it "is invalid without a body" do
    build(:page, :body => nil).should_not be_valid
    build(:page, :body => "").should_not be_valid
  end

  it "is invalid without a distinct URL" do
    create(:page, :url => "moose")
    build(:page, :url => "moose").should_not be_valid
  end
end
