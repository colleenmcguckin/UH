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

  show do
    attributes_table do
      row :agency_name
      row :street_address
      row :city
      row :state
      row :zip
      row :last_sign_in_at
      row :last_sign_in_ip
    end

    table_for donor.donations do
      column "Donor", :donor do |d|
        link_to(d.donor.agency_name, admin_donor_path(d.donor))
      end

      column "Donation Date", :donated_at do |d|
        d.donated_at
      end

      column "Items" do |d|
        d.items.map{ |i| i.food.name }.to_sentence
      end

      column 'Tracking Code' do |d|
        d.tracking_code
      end

      column 'Status' do |d|
        if d.donated?
          if d.received?
            'Received'
          else
            'Donated'
          end
        else
          'In Progress'
        end
      end
    end
  end

end
