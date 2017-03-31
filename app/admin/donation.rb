ActiveAdmin.register Donation do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
  permit_params :donor_id, :receiver_id, :confirmed_by_donor_at, :donated_at, :received_at, :total_weight,
              :total_value_dollars, :total_meals, items_attributes: [:id, :food_id, :quantity, :quantity_type, :_destroy]

  config.batch_actions = false

  scope :all, default: true
  scope :donated
  scope :received

  index do
    column :donor
    column :receiver
    column :confirmed_by_donor_at
    column :donated_at
    column :received_at
    column :total_weight
    column :total_value_dollars
    column :total_meals
    column :tracking_code
    actions
  end

  show do
    columns do
      column do
        attributes_table do
          row :donor
          row :receiver
          row :confirmed_by_donor_at
          row :donated_at
          row :received_at
          row :total_weight
          row :total_value_dollars
          row :total_meals
          row :tracking_code
        end
      end
      column do
        panel 'Items' do
          ul do
            donation.items.each do |item|
              li do
                "#{item.quantity} #{item.quantity_type} of #{item.food&.name&.titleize}"
              end
            end
          end
        end
      end
    end
  end

  form do |f|
    inputs 'Donation Details' do
      input :receiver, as: :select, collection: Receiver.all.map(&:agency_name)
      input :donor, as: :select, collection: Donor.all.map(&:agency_name)
      input :total_weight, hint: 'In Pounds'
      input :total_value_dollars
      input :total_meals
    end

    inputs 'Donation Items' do
      has_many :items, allow_destroy: true do |d|
        d.input :food_id, as: :search_select, url: admin_foods_path,
                fields: [:agency_name, :email], display_name: 'agency_name', minimum_input_length: 2
      end
    end

    actions
  end

end
