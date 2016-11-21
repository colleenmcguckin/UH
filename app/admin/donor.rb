ActiveAdmin.register Donor do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  index do
   column(:agency_name)
   column(:contact_name)
   column(:city)
   column(:state)
   column 'Completed Donations' do |donor|
     donor.donations.select{ |d| d.received? }.count
   end
   column 'Waiting for Confirmation' do |donor|
     donor.donations.select{ |d| d.donated? }.reject{ |d| d.received? }.count
   end
   column(:last_sign_in_at)
   acions
  end

  filter :email
  filter :contact_name
  filter :city
  filter :state
  filter :last_sign_in_at, as: :datepicker

end
