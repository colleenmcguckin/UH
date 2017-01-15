class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout 'mailer'

  def added_to_donation_mailer donation
    @receiver = donation.receiver
    @donor = donation.donor
    @donation = donation
    @url = 

    mail(to: @receiver.contact_details.first.dfr_contact_email, subject: 'Urban Harvester - You have been added to a donation!')
  end

end
