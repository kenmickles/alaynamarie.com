class Admin::SettingsController < Admin::AdminController
  after_filter :expire_cache, :only => [:create, :update, :destroy]

  def edit
    @page_title = "Edit setting: #{@setting.name.humanize}"
  end

  private

  # expire all cached pages to pick up the new settings
  def expire_cache
    Book.all.each { |b| expire_action "show_book_#{b.id}" }
    Page.all.each do |page|
      expire_action "show_page_#{page.url}"
      expire_action "show_page_#{page.id}"
    end
  end
end