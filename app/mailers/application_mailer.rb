class ApplicationMailer < ActionMailer::Base
  default from: "uh.donationportal@gmail.com"
  layout 'mailer'

  def added_to_donation_mailer donation
    @receiver = donation.receiver
    @donor = donation.donor
    @donation = donation
    @url =

    mail(to: @receiver.contact_details.first.dfr_contact_email, subject: 'Urban Harvester - You have been added to a donation!')
  end

  def donation_received_mailer donation
    @receiver = donation.receiver
    @donor = donation.donor
    @donation = donation
    @url =

    mail(to: @receiver.contact_details.first.dfr_contact_email, subject: 'Urban Harvester - Your donation has been received!')
  end
end
