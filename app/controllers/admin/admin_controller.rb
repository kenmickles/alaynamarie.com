class Admin::AdminController < ApplicationController
  before_filter :authenticate!
  before_filter :fetch_record, :only => [:show, :edit, :update, :destroy]

  layout "admin"

  def index
    @records = model_name.classify.constantize.all
    self.instance_variable_set("@#{controller_name}", @records)
    @page_title = controller_name.titlecase
  end

  def show
    redirect_to send("#{model_name}_path", @record)
  end

  def new
    new_record
    @page_title = "New #{model_name.titlecase}"
  end

  def create
    new_record(params[model_name])

    if @record.save
      flash[:notice] = "#{model_name.titlecase} created successfully."
      redirect_to after_save_redirect_path
    else
      render "admin/#{controller_name}/new"
    end
  end

  def edit
    @page_title = "Edit #{model_name.titlecase} ##{@record.id}"
  end

  def update
    if @record.update_attributes(params[model_name])
      flash[:notice] = "#{model_name.titlecase} ##{params[:id]} updated successfully."
      redirect_to after_save_redirect_path
    else
      render "admin/#{controller_name}/edit"
    end
  end

  def destroy
    if @record.destroy
      flash[:notice] = "#{model_name.titlecase} ##{params[:id]} was destroyed."
    else
      flash[:alert] = "#{model_name.titlecase} ##{params[:id]} could not be destroyed."
    end

    redirect_to after_save_redirect_path
  end

  protected

  def authenticate!
    authenticate_or_request_with_http_basic do |name, password|
      name == ENV['HTTP_USERNAME'] && password == ENV['HTTP_PASSWORD']
    end
  end

  def fetch_record
    @record = model_name.classify.constantize.find(params[:id])
    self.instance_variable_set("@#{model_name.downcase}", @record)
  end

  def new_record(defaults = {})
    @record = model_name.classify.constantize.new(defaults)
    self.instance_variable_set("@#{model_name}", @record)
  end

  def model_name
    controller_name.singularize
  end

  def after_save_redirect_path
    send("admin_#{controller_name}_path")
  end
end