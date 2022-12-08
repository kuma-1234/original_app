class RemoveIntroduceYearFromProfiles < ActiveRecord::Migration[6.1]
  def change
    remove_column :profiles, :introduce_year
  end
end
