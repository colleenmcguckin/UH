ActiveAdmin.register Food do

  permit_params :name, :description, :storage_temp, :prepared_meal, :donor_id, :category_id

  index do
    column :donor
    column :name
    column :description
    column :storage_temp
    column :category
    column :prepared_meal
    column "Archived?" do |food|
      food.archived? ? status_tag("Yes", :ok) : status_tag("No")
    end
  end

  show do
    attributes_table do
      row :donor
      row :name
      row :description
      row :storage_temp
      row :category
      row :prepared_meal
      row "Archived?" do |food|
        food.archived? ? status_tag("Yes", :ok) : status_tag("No")
      end
    end
  end

  filter :donor, collection: -> { (Donor.all).map{ |d| [d.agency_name, d.id] } }
  filter :category
  filter :name
  filter :description
  filter :storage_temp
  filter :preapred_meal

  form do |f|
    inputs do
      input  :name
      input  :description
      input  :storage_temp, as: :select, collection: StorageTemp.all.map(&:description)
      input  :prepared_meal, label: "This food is a prepared meal."
      input  :donor, as: :select, collection: Donor.all.map{ |d| [d.agency_name, d.id] }
      input  :category, as: :select, collection: Category.all.map{ |c| [c.name, c.id] }
    end
    actions
  end
end
