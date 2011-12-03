module ApplicationHelper
  
  # Return a title on a per-page basis
  def title
    base_title = "Victoria University Libraries Student Pay"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  def logo
    image_tag("logo.png", :alt => "Sample App")
  end

  def home_path
    if signed_in?
      return home_admins_path if current_user.admin?
      return @supervisors if current_user.supervisor?
      return root_path if current_user.part_time_employee
    end
  end
end
