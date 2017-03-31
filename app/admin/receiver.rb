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
    panel "Donations" do
      table_for receiver.donations do
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
    columns do
      column do
        panel "Daily Food Recovery Contact Details" do
          attributes_table_for receiver.contact_details do
            row("Name") { |contact| contact.dfr_contact_name }
            row("Email") { |contact| contact.dfr_contact_email }
            row("Office Phone") { |contact| contact.dfr_contact_office_phone }
            row("Cell Phone") { |contact| contact.dfr_contact_cell_phone }
            row("Preferred Contact Method") { |contact| contact.dfr_preferred_contact_method }
          end
        end
      end
      column do
        panel "General Contact Details" do
          attributes_table_for receiver.contact_details do
            row("Name") { |contact| contact.contact_name }
            row("Email") { |contact| contact.contact_email }
            row("Phone") { |contact| contact.contact_phone }
          end
        end
      end
      column do
        panel "Donation Schedule" do
          receiver.donation_schedules.order(:day_of_week).each do |day|
            span "#{table_schedule_text(day)}"
            br
          end
        end
      end
    end
    columns do
      column do
        panel "Logistics" do
          attributes_table_for receiver.logistics do
            row :transportation_available
            row :driver_status
            row :insurance_status
            row :vehicle_style
            row :freezer_type
            row :refrigerator_type
            row :indoor_dry_storage
            row :safe_handling_program
            row :meal_usage
            row :meal_distribution_frequency
          end
        end
      end
      column do
        panel "Program" do
          attributes_table_for receiver.programs do
            row :perishable_food_distribution
            row :charge_for_service
            row :meal_style
            row :staff_size
            row :food_type_provided
          end
        end
      end
    end

    columns do
      column do
        panel "Food Restrictions" do
          receiver.restrictions.each do |restriction|
            if restriction.categories.any?
              restriction.categories.each do |category|
                span "#{category.name}"
                br
              end
            else
              "None Set"
            end
          end
        end
      end

      column do
        panel "Storage Restrictions" do
          receiver.restrictions.each do |restriction|
            if restriction.storage_temps.any?
              restriction.storage_temps.each do |storage_temp|
                span "#{storage_temp.description}"
                br
              end
            else
              "None Set"
            end
          end
        end
      end
    end
    columns do
      column do
        panel "Gender Demographics" do
          attributes_table_for receiver.demographics do
            row :percent_male
            row :percent_female
          end
        end
      end
      column do
        panel "Age Demographics" do
          attributes_table_for receiver.demographics do
            row :percent_youth
            row :percent_adult
            row :percent_senior
          end
        end
      end
      column do
        panel "Employment Demographics" do
          attributes_table_for receiver.demographics do
            row :precent_employed
            row :percent_unemployed
            row :percent_veteran_military
            row :percent_active_military
          end
        end
      end
      column do
        panel "Family Demographics" do
          attributes_table_for receiver.demographics do
            row :percent_single_no_kids
            row :percent_single_with_kids
            row :percentage_married_no_kids
            row :percentage_married_with_kids
          end
        end
      end
    end
    columns do
      column do
        panel "Nationality Demographics" do
          attributes_table_for receiver.demographics do
            row :percent_american_native
            row :percent_african_american
            row :percent_asian
            row :percent_hispanic
            row :percent_pacific_islander
            row :percent_white
            row :percent_portuguese
            row :percent_other_nationality
          end
        end
      end
      column do
        panel "Consumption Demographics" do
          attributes_table_for receiver.demographics do
            row :percentage_with_dietary_restrictions
            row :total_guests_served_per_week
            row :meals_served_per_breakfast
            row :meals_served_per_lunch
            row :meals_served_per_dinner
            row :total_receiving_groceries
            row :mode_of_transportation
            row :distance_traveled
          end
        end
      end
    end
  end

  form do

  end

end
