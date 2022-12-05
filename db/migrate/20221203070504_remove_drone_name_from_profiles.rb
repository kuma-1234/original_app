class RemoveDroneNameFromProfiles < ActiveRecord::Migration[6.1]
  def change
    remove_column :profiles, :drone_name, :string
  end
end
