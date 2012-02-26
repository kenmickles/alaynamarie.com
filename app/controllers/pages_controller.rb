class PagesController < ApplicationController
  def show
    begin
      if params[:url].present?
        @page = Page.find_by_url(params[:url])
      else
        @page = Page.find(params[:id])
      end

      @page_title = @page.title
      @body_class = @page.url.underscore
    rescue
      render :file => "public/404.html", :status => 404, :layout => false
    end
  end
end