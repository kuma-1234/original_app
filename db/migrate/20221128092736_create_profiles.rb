class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.string :prefecture
      t.string :drone_name
      t.string :main_crop
      t.date :introduce_year
      t.text :self_introduce
      t.belongs_to :user, index: { unique: true }, foreign_key: true


      t.timestamps
    end
  end
end
