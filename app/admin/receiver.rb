ActiveAdmin.register Receiver do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :email,
              :password,
              :agency_name,
              :street_address,
              :city,
              :state,
              :zip,
              :tax_id,
              :paused,
              :web_url,
              :intake_survey_completed,
              contact_details_attributes: [:id,
                                           :dfr_contact_name,
                                           :dfr_contact_email,
                                           :dfr_contact_office_phone,
                                           :dfr_contact_cell_phone,
                                           :dfr_preferred_contact_method,
                                           :contact_name,
                                           :contact_email,
                                           :contact_phone],
              logistics_attributes: [:id,
                                     :transportation_available,
                                     :driver_status,
                                     :insurance_status,
                                     :vehicle_style,
                                     :freezer_type,
                                     :refrigerator_type,
                                     :indoor_dry_storage,
                                     :safe_handling_program,
                                     :meal_usage,
                                     :meal_distribution_frequency],
              programs_attributes: [:id,
                                    :perishable_food_distribution,
                                    :food_type_provided,
                                    :charge_for_service,
                                    :meal_style,
                                    :staff_size,
                                    dietary_restriction_ids: []],
              restrictions_attributes: [:id,
                                        category_ids: [],
                                        storage_temp_ids: []],
              demographics_attributes: [:id,
                                        :percent_male,
                                        :percent_female,
                                        :percent_youth,
                                        :percent_adult,
                                        :percent_senior,
                                        :percent_white,
                                        :percent_african_american,
                                        :percent_asian,
                                        :percent_hispanic,
                                        :percent_american_native,
                                        :percent_pacific_islander,
                                        :percent_portuguese,
                                        :percent_other_nationality,
                                        :percent_single_no_kids,
                                        :percent_single_with_kids,
                                        :percentage_married_no_kids,
                                        :percentage_married_with_kids,
                                        :precent_employed,
                                        :percent_unemployed,
                                        :percent_veteran_military,
                                        :percent_active_military,
                                        :percentage_with_dietary_restrictions,
                                        :total_guests_served_per_week,
                                        :mode_of_transportation,
                                        :distance_traveled,
                                        :meals_served_per_breakfast,
                                        :meals_served_per_lunch,
                                        :meals_served_per_dinner,
                                        :total_receiving_groceries]

# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
  controller do
    def update
      params.permit!
      super
    end
  end

  action_item :edit_schedule, only: :show do
    if receiver.donation_schedules.any?
      link_to 'Edit Schedule', receiver_donation_schedules_path(receiver.id)
    else
      link_to 'Add Donation Schedule', receiver_donation_schedules_path(receiver.id)
    end
  end

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
            row :dietary_restrictions do
              receiver.programs.first.dietary_restrictions.map(&:name).to_sentence
            end
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

  form do |f|
    inputs 'Agency Info' do
      input :email
      # input :password
      input :agency_name
      input :street_address
      input :city
      input :state
      input :zip
      input :tax_id
      input :paused
      input :web_url
      input :intake_survey_completed
    end
    actions

    unless f.object.new_record?
      h3 'IMPORTANT: Add only 1 contact detail set to a receiving agency. The existing record should be edited if changes are needed.'
      inputs 'Contact Information' do
        f.has_many :contact_details, new_record: "Add Contact Detail set" do |c|
          c.input :dfr_contact_name
          c.input :dfr_contact_email
          c.input :dfr_contact_office_phone
          c.input :dfr_contact_cell_phone
          c.input :dfr_preferred_contact_method, as: :select, collection: %w[cell office email]
          c.input :contact_name
          c.input :contact_email
          c.input :contact_phone
        end
      end
      actions
    end

    unless f.object.new_record?
      h3 'IMPORTANT: Add only 1 logistic set to a receiving agency. The existing record should be edited if changes are needed.'
      inputs 'Logistics' do
        f.has_many :logistics, new_record: "Add Logistic set" do |l|
          l.input :transportation_available, as: :select, collection: %w[Yes No], label: 'Do you provide transportation for the pickup of donated food?'
          l.input :driver_status, as: :select, collection: ['Staff', 'Volunteers', 'Both', 'n/a'], label: 'Are your drivers staff or volunteers?'
          l.input :insurance_status, as: :select, collection: ['Our organization provides insurance to drivers', 'Our drivers have their own private insurance.', 'n/a'], label: 'How are your drivers insured?'
          l.input :vehicle_style, as: :select, collection: ['Car', 'Pickup Truck', 'Box Truck', 'Refrigerated Vehicle', 'Other', 'n/a'], label: 'What type of vehicle do you use?'
          l.input :freezer_type, as: :select, collection: ['Upright', 'Walk-in', 'Kitchen Fridge/Freezer Combo', 'n/a'], label: 'What type of freezer does your facility use?'
          l.input :refrigerator_type, as: :select, collection: ['Upright', 'Walk-in', 'Kitchen Fridge/Freezer Combo', 'n/a'], label: 'What type of refrigerator does your facility use?'
          l.input :indoor_dry_storage, as: :select, collection: %w[Yes No], label: 'Do you have indoor dry storage space?'
          l.input :safe_handling_program, as: :select, collection: ['Trained Staff', 'Serve Safe', 'Food Safety Manager National Registry of Food Safety Professionals', 'National registry of food safety professionals', 'None'], label: 'What safe food handling or public health certification is in place?'
          l.input :meal_usage, as: :select, collection: ['We provide meals or groceries only.', 'Providing meals is part of a larger program we offer.'], label: 'How does the donation of fresh food fit into your organization?'
          l.input :meal_distribution_frequency, as: :select, collection: ['Multiple times per day', 'Daily', 'Multiple times per week', 'Weekly', 'Other', 'n/a'], label: 'How often do you provide food to your clients?'
        end
      end
      actions
    end
    unless f.object.new_record?
      h3 'IMPORTANT: Add only 1 program to a receiving agency. The existing record should be edited if changes are needed.'
      inputs 'Program Details' do
        f.has_many :programs, new_record: "Add Program" do |p|
          p.input :perishable_food_distribution, as: :select, collection: %w[Yes No], label: 'Does your agency have a perishable food distribution program in place?'
          p.input :food_type_provided, as: :select, collection: ['Full Meals', 'Groceries', 'Both', 'n/a'], label: 'Does your agency provide meals or groceries to your clients?'
          p.input :charge_for_service, as: :select, collection: %w[Yes No], label: 'Do you charge guests for the groceries or meals you offer?'
          p.input :meal_style, as: :select, collection: ['Take Out', 'Eat In', 'Both', 'n/a'], label: 'How are the meals provided?'
          p.input :staff_size, input_html: {value: 0, min: 0}, label: 'How many people are on your staff?'
          p.input :dietary_restriction_ids, as: :check_boxes, collection: DietaryRestriction.all.to_a, label_method: :name, label: 'Check off the dietary restrictions you accomodate:'
        end
      end
    end
    actions

    unless f.object.new_record?
      h3 'IMPORTANT: Add only 1 set of restrictions to a receiving agency. The existing record should be edited if changes are needed.'
      inputs 'Restrictions' do
        f.has_many :restrictions, new_record: "Add Restriction Set" do |r|
          r.input :categories, as: :check_boxes, collection: Category.all.to_a, label_method: :name, label: 'Check the food categories you are not able to receive:'
          r.input :storage_temps, as: :check_boxes, collection: StorageTemp.all.map{ |st| [st.description, st.id]}, label_method: :first, value_method: :last, label: 'Check the storage methods you are not able to accomodate:'
        end
      end
    end
    actions

    unless f.object.new_record?
      h3 'IMPORTANT: Add only 1 set of gender demographics to a receiving agency. The existing record should be edited if changes are needed.'
      inputs 'Gender Demographics' do
        f.has_many :demographics, new_record: "Add Demographic Set" do |d|
          d.label "Gender"
          d.input :percent_male, as: :radio, collection: Demographic::PERCENTAGE_RANGES, label: "% Male"
          d.input :percent_female, as: :radio, collection: Demographic::PERCENTAGE_RANGES, label: "% Female"
          d.label "Age"
          d.input :percent_youth, as: :radio, collection: Demographic::PERCENTAGE_RANGES, label: "% Youth"
          d.input :percent_adult, as: :radio, collection: Demographic::PERCENTAGE_RANGES, label: "% Adult"
          d.input :percent_senior, as: :radio, collection: Demographic::PERCENTAGE_RANGES, label: "% Senior"
          d.label 'Nationality'
          d.input :percent_white, as: :radio, collection: Demographic::PERCENTAGE_RANGES, label: "% White"
          d.input :percent_african_american, as: :radio, collection: Demographic::PERCENTAGE_RANGES, label: "% African American"
          d.input :percent_asian, as: :radio, collection: Demographic::PERCENTAGE_RANGES, label: "% Asian"
          d.input :percent_hispanic, as: :radio, collection: Demographic::PERCENTAGE_RANGES, label: "% Hispanic"
          d.input :percent_american_native, as: :radio, collection: Demographic::PERCENTAGE_RANGES, label: "% American Native"
          d.input :percent_pacific_islander, as: :radio, collection: Demographic::PERCENTAGE_RANGES, label: "% Pacific Islander"
          d.input :percent_portuguese, as: :radio, collection: Demographic::PERCENTAGE_RANGES, label: "% Portuguese"
          d.input :percent_other_nationality, as: :radio, collection: Demographic::PERCENTAGE_RANGES, label: "% Other"
          d.label "Family"
          d.input :percent_single_no_kids, as: :radio, collection: Demographic::PERCENTAGE_RANGES, label: "% Single, no kids"
          d.input :percent_single_with_kids, as: :radio, collection: Demographic::PERCENTAGE_RANGES, label: "% Single with kids"
          d.input :percentage_married_no_kids, as: :radio, collection: Demographic::PERCENTAGE_RANGES, label: "% Married, no kids"
          d.input :percentage_married_with_kids, as: :radio, collection: Demographic::PERCENTAGE_RANGES, label: "% Married with kids"
          d.label "Employment"
          d.input :precent_employed, as: :radio, collection: Demographic::PERCENTAGE_RANGES, label: "% Employed"
          d.input :percent_unemployed, as: :radio, collection: Demographic::PERCENTAGE_RANGES, label: "% Unemployed"
          d.label "Military"
          d.input :percent_veteran_military, as: :radio, collection: Demographic::PERCENTAGE_RANGES, label: "% Veteran Military"
          d.input :percent_active_military, as: :radio, collection: Demographic::PERCENTAGE_RANGES, label: "% Active Military"
          d.label "Guests"
          d.input :percentage_with_dietary_restrictions, as: :radio, collection: Demographic::PERCENTAGE_RANGES, label: "% With Dietary Restrictions"
          d.input :total_guests_served_per_week, input_html: {min: 0}, label: "Total Guests Served Per Week"
          d.label "Transportation"
          d.input :mode_of_transportation, as: :radio, collection: ['Walk', 'Car', 'Public Transportation', 'Shuttle', 'Clients live on site', 'n/a'], label: "Main Transportation Mode"
          d.input :distance_traveled, as: :radio, collection: ['Less than 1 mile', '1 - 4 miles', '5 - 10 miles', '10+ miles', 'Clients live on site', 'n/a'], label: "Average Distance Traveled"
          d.label "Meals"
          d.input :meals_served_per_breakfast, input_html: {value: d.object.meals_served_per_breakfast || 0, min: 0 }, label: "# of Meals Served per Breakfast"
          d.input :meals_served_per_lunch, input_html: {value: d.object.meals_served_per_lunch || 0, min: 0 }, label: "# of Meals Served per Lunch"
          d.input :meals_served_per_dinner, input_html: {value: d.object.meals_served_per_dinner || 0, min: 0 }, label: "# of Meals Served per Dinner"
          d.input :total_receiving_groceries, input_html: {value: d.object.total_receiving_groceries || 0, min: 0 }, label: "# of Clients Receiving Groceries"
        end
      end
    end
    actions
  end
end
