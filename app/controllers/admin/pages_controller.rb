class Admin::PagesController < Admin::AdminController
  after_filter :expire_cache, :only => [:update]
  
  private
  
  def expire_cache
    expire_action "show_page_#{@page.url}"
    expire_action "show_page_#{@page.id}"
  end
end