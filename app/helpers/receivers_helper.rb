module ReceiversHelper

  def pending_items_in_strings receiver
    if receiver.pending_donation_items.any?
      receiver.pending_donation_items.map { |i| "#{i.quantity} #{i.quantity_type} of #{i.food.name}" }
    else
      ["None right now!"]
    end
  end

end
