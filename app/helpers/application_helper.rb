module ApplicationHelper

  def user_path user
    case user
    when user.receiver?
      receiver_path user
    when user.donor?
      donor_path user
    end
  end

  def user_donations_path user
    case user
    when user.receiver?
      receiver_donations_path user
    when user.donor?
      donor_donations_path user
    end
  end
end
