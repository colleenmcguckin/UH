module ApplicationHelper

  def flash_class(level)
    case level
      when 'notice' then "alert alert-dismissible alert-info"
      when 'success' then "alert alert-dismissible alert-success"
      when 'warning' then "alert alert-dismissible alert-warning"
      when 'danger' then "alert alert-dismissible alert-danger"
    end
  end

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
