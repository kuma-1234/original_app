class AddProfileRefToDrones < ActiveRecord::Migration[6.1]
  def change
    add_reference :drones, :profile, null: false, foreign_key: true
  end
end
