ActiveAdmin.register Food do

  permit_params :name, :description, :storage_temp

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
      input  :donor, as: :select, collection: Donor.all.map(&:agency_name)
      input  :category, as: :select, collection: Category.all.map(&:name)
    end
  end
end
