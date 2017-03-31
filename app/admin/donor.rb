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
    actions
  end

  filter :email
  filter :contact_name
  filter :city
  filter :state
  filter :last_sign_in_at, as: :datepicker

  show do
    attributes_table do
      row :agency_name
      row :contact_name
      row :street_address
      row :city
      row :state
      row :zip
      row :last_sign_in_at
      row :last_sign_in_ip
    end

    table_for donor.donations do
      column "Recipient", :receiver do |d|
        link_to(d.receiver.agency_name, admin_receiver_path(d.receiver)) if d.receiver
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

  form do
    
  end

end
