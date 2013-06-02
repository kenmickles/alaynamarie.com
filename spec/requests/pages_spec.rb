require 'spec_helper'

describe "Pages" do
  describe "GET /pages/:id" do
    it "finds page by id" do
      page = create(:page)
      get page_path(page.id)
      response.should render_template :show
      assigns(:page).should eq page
    end

    it "finds page by URL" do
      page = create(:page)
      get "/#{page.url}"
      response.should render_template :show
      assigns(:page).should eq page
    end

    it "404s on unknown URL" do
      get Faker::Company::catch_phrase.parameterize
      response.status.should eq 404
    end
  end
end