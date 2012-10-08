module ApplicationHelper

def show_topbar
  if current_user
    if current_user.try(:admin) 
      render "admin_topbar"
    else  
     render "topbar"
    end
  else
    render "guest_topbar"
  end
end

def show_header
  render "header"
end

def logo
  render "logo"
end
end
