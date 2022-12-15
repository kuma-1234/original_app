class ChangeColumnsAddNotNullOnBlogs < ActiveRecord::Migration[6.1]
  def change
    change_column_null :blogs, :pesticide_type, false
    change_column_null :blogs, :crop, false
    change_column_null :blogs, :spray_area, false
    change_column_null :blogs, :content, false
  end
end
