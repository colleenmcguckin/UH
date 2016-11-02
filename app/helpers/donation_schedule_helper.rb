module DonationScheduleHelper

  def minutes_to_string(minutes)
    if minutes.zero?
      '00'
    elsif minutes == 5
      '05'
    else
      minutes.to_s
    end
  end

end
