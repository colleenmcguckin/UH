class AddAasmStateToDonations < ActiveRecord::Migration
  def change
    add_column :donations, :aasm_state, :string
  end
end
