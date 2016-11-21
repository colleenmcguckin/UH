ActiveAdmin.register Receiver do

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
    column 'Incoming Donations' do |receiver|
      receiver.donations.select{ |d| d.donated? }.reject{ |d| d.received? }.count
    end
    column 'Completed Donations' do |receiver|
      receiver.donations.select{ |d| d.received? }.count
    end
    actions
  end

  filter :agency_name
  filter :contact_name
  filter :city
  filter :state

end
