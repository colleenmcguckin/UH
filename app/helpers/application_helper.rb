module ApplicationHelper

  def am_or_pm hour
    if hour < 12
      'am'
    else
      'pm'
    end
  end

  def twelve_hour hour
    if hour > 12
      hour - 12
    else
      hour.zero? ? 12 : hour
    end
  end

end
