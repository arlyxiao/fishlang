module ApplicationHelper

  def got_point_by(user_practice)
    return 1 if user_practice.error_count == 1
    
    return 10 if user_practice.error_count == 0
  end
end
