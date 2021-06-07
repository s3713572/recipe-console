module ApplicationHelper
  def get_activate_nav(name)
    "nav-link #{'active' if params[:controller] == name}"
  end
end
