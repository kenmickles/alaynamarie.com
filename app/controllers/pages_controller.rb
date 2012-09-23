class PagesController < ApplicationController
  caches_action :show, :cache_path => Proc.new { |c| "show_page_#{c.params[:url] || c.params[:id]}" }
  
  def show
    if params[:url].present?
      @page = Page.find_by_url(params[:url])
    else
      @page = Page.find_by_id(params[:id])
    end
    
    if @page.nil?
      render :file => "public/404.html", :status => 404, :layout => false
    else
      @page_title = @page.title
      @body_class = @page.url.underscore
    end
  end
end