class CreateDrones < ActiveRecord::Migration[6.1]
  def change
    create_table :drones do |t|
      t.string :drone_name

      t.timestamps
    end
  end
end
