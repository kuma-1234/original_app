class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.references :blog, null: false, foreign_key: true
      t.string :talk

      t.timestamps
    end
  end
end
