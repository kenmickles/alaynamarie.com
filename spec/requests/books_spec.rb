require 'spec_helper'

describe "Books" do
  describe "GET /books/:id" do
    it "renders show template" do
      book = create(:book)
      3.times { create(:photo, :book => book) }
      get book_path(book.id)
      response.should render_template :show
      assigns(:book).should eq book
    end
  end
end