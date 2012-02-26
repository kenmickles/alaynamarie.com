class PagesController < ApplicationController
  def show
    if params[:url].present?
      @page = Page.find_by_url(params[:url])
    else
      @page = Page.find(params[:id])
    end
    
    @page_title = @page.title
    @body_class = @page.url.underscore
  end
end