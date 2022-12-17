FactoryBot.define do 
  factory :blog do
    work_date { '2022-6-17' }
    pesticide_type { '粒剤' }
    pesticide_name { '1キロ粒剤' }
    crop { 'えだまめ' }
    variety { 'コシヒカリ' }
    flight_speed { '919' }
    spray_area { '2' }
    content { 'テストテスト' }
    status { 'public' }
  end
  factory :blog2, class: Blog do
    work_date { '2022-4-19' }
    pesticide_type { '液剤' }
    pesticide_name { '△液剤' }
    crop { '稲' }
    variety { 'こしいぶき' }
    spray_area { '3' }
    content { 'アイウエオ' }
    status { 'public' }
  end
  factory :blog3, class: Blog do
    work_date { '2022-8-25' }
    pesticide_type { '液剤' }
    pesticide_name { '◯液剤' }
    crop { '大豆' }
    variety { 'フクユタカ' }
    spray_area { '4' }
    content { 'カキクケコ' }
    status { 'private' }
  end
  factory :blog4, class: Blog do
    work_date { '2022-9-19' }
    pesticide_type { '液剤' }
    pesticide_name { '△液剤' }
    crop { '稲' }
    variety { 'フクユタカ' }
    spray_area { '3' }
    content { 'サシスセソ' }
    status { 'public' }
  end
  factory :blog5, class: Blog do
    work_date { '2022-8-25' }
    pesticide_type { '液剤' }
    pesticide_name { '◯液剤' }
    crop { '大豆' }
    variety { 'こしいぶき' }
    spray_area { '4' }
    content { 'タチツテト' }
    status { 'private' }
  end
end