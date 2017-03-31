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
    return if hour.nil?
    if hour < 12
      'am'
    else
      'pm'
    end
  end

  def twelve_hour hour
    return if hour.nil?
    if hour > 12
      hour - 12
    else
      hour.zero? ? 12 : hour
    end
  end

  def table_schedule_text day
    if day.closed?
      "#{day.day_of_week_in_words.upcase}: Closed"
    else
      "#{day.day_of_week_in_words.upcase}: #{twelve_hour(day.open_at_hour)}:#{minutes_to_string(day.open_at_minute)} #{am_or_pm(day.open_at_hour)} to #{twelve_hour(day.close_at_hour)}:#{minutes_to_string(day.close_at_minute)} #{am_or_pm(day.close_at_hour)}"
    end
  end

  def unscoped_food id
    Food.unscoped.find(id)
  end

  def format_date_long date
    date&.strftime("%m/%d/%Y")
  end

  def donation_status_text donation
    if donation.donated? && donation.received?
      content_tag(:div, "Confirmed", class: ["green", "italic"])
    elsif donation.donated?
      content_tag(:div, "Donated", class: ["blue", "italic"])
    else
      content_tag(:div, "Pending", class: ["orange", "italic"])
    end
  end

end
