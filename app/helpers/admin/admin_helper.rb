module Admin::AdminHelper
  
  def active_tab
    controller_name == "photos" ? "books" : controller_name
  end
  
end