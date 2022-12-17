class ChangeColumnsAddNotNullOnComments < ActiveRecord::Migration[6.1]
  def change
    change_column_null :comments, :talk, false
  end
end
