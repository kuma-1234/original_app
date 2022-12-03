class CreateBlogs < ActiveRecord::Migration[6.1]
  def change
    create_table :blogs do |t|
      t.text :picture
      t.text :content
      t.date :work_date
      t.integer :pesticide_type
      t.string :pesticide_name
      t.string :flight_speed
      t.string :rpm
      t.string :shutter_opening
      t.string :crop
      t.string :variety
      t.string :spray_area

      t.timestamps
    end
  end
end
