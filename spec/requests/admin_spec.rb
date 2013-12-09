require 'spec_helper'

def http_login
  @env ||= {}
  @env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(ENV['HTTP_USERNAME'], ENV['HTTP_PASSWORD'])
end

def test_index(model)
  describe "GET /admin/#{model.to_s.pluralize}" do
    it "raises unauthorized if not logged in" do
      get send("admin_#{model.to_s.pluralize}_path")
      response.status.should eq 401
    end

    it "renders index template" do
      http_login
      3.times { create(model) }
      get send("admin_#{model.to_s.pluralize}_path"), {}, @env
      response.should render_template :index
      assigns(:records).first.should be_a_kind_of model.classify.constantize
      assigns(model.pluralize).first.should be_a_kind_of model.classify.constantize
    end
  end
end

def test_edit(model)
  describe "GET /admin/#{model.to_s.pluralize}/:id/edit" do
    it "raises unauthorized if not logged in" do
      object = create(model)
      get send("edit_admin_#{model}_path", object)
      response.status.should eq 401
    end

    it "renders edit template" do
      http_login
      object = create(model)
      get send("edit_admin_#{model}_path", object), {}, @env
      response.should render_template :edit
      assigns(:record).should be_a_kind_of model.classify.constantize
      assigns(model).should be_a_kind_of model.classify.constantize
    end
  end
end

def test_new(model)
  describe "GET /admin/#{model.to_s.pluralize}/new" do
    it "raises unauthorized if not logged in" do
      get send("new_admin_#{model}_path")
      response.status.should eq 401
    end

    it "renders new template" do
      http_login
      get send("new_admin_#{model}_path"), {}, @env
      response.should render_template :new
      assigns(:record).should be_a_kind_of model.classify.constantize
      assigns(model).should be_a_kind_of model.classify.constantize
    end
  end
end

def test_create(model)
  describe "POST /admin/#{model.to_s.pluralize}" do
    it "raises unauthorized if not logged in" do
      object = create(model)
      post send("admin_#{model.to_s.pluralize}_path", object), {model => object.as_json}
      response.status.should eq 401
    end

    it "creates #{model} and redirects" do
      http_login
      old_count = model.classify.constantize.count
      object = build(model)
      post send("admin_#{model.to_s.pluralize}_path", object), {model => object.as_json}, @env
      model.classify.constantize.count.should be > old_count
      response.status.should eq 302
    end
  end
end


def test_update(model, params)
  describe "PUT /admin/#{model.to_s.pluralize}/:id" do
    it "raises unauthorized if not logged in" do
      object = create(model)
      put send("admin_#{model}_path", object), {model => params}
      response.status.should eq 401
    end

    it "updates #{model} and redirects" do
      http_login
      object = create(model)
      put send("admin_#{model}_path", object), {model => params}, @env

      object.reload
      params.each_pair do |key, val|
        object.read_attribute(key).should eq val
      end

      response.status.should eq 302
    end
  end
end

def test_destroy(model)
  describe "DELETE /admin/#{model.to_s.pluralize}/:id" do
    it "raises unauthorized if not logged in" do
      object = create(model)
      delete send("admin_#{model}_path", object)
      response.status.should eq 401
    end

    it "deletes #{model} and redirects" do
      http_login
      object = create(model)
      delete send("admin_#{model}_path", object), {}, @env
      response.status.should eq 302
      model.classify.constantize.find_by_id(object.id).should be_nil
    end
  end
end

describe "Admin" do
  describe "Books" do
    test_index "book"
    test_edit "book"
    test_update "book", {:name => Faker::Company.bs, :description => Faker::Lorem.paragraph}
  end

  describe "Pages" do
    test_index "page"
    test_edit "page"
    test_update "page", {:title => Faker::Company.catch_phrase, :body => Faker::Lorem.paragraph}
  end

  describe "Photos" do
    test_new "photo"
    test_edit "photo"
    test_update "photo", {:caption => Faker::Company.bs, :weight => rand(1..1000)}
    test_create "photo"
    test_destroy "photo"
  end

  describe "Settings" do
    test_index "setting"
    test_edit "setting"
    test_update "setting", {value: Faker::Lorem.sentence }
  end
end