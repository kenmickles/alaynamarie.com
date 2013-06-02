class PagesController < ApplicationController
  caches_action :show, :cache_path => Proc.new { |c| "show_page_#{c.params[:url] || c.params[:id]}" }

  def show
    if params[:url].present?
      @page = Page.find_by_url(params[:url])
    else
      @page = Page.find_by_id(params[:id])
    end

    if @page.present?
      @page_title = @page.title
      @body_class = "pages show #{@page.url.dasherize}"
    else
      render :file => "public/404", :status => 404, :layout => false, :format => "html"
    end
  end
end