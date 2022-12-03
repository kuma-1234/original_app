class CreateMatchDrones < ActiveRecord::Migration[6.1]
  def change
    create_table :match_drones do |t|
      t.references :blog, foreign_key: true
      t.references :drone, foreign_key: true
      
      t.timestamps
    end
  end
end
