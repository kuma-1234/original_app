FactoryBot.define do
  factory :profile do
    prefecture { '北海道' }
    main_crop { '米・玉ねぎ・じゃがいも' }
    self_introduce { 'テストですー' }
  end
  factory :profile2, class: Profile do
    prefecture { '沖縄' }
    main_crop { 'さとうきび' }
    self_introduce { 'めんそーれ' }
  end
  factory :profile3, class: Profile do
    prefecture { '新潟' }
    main_crop { '米・大豆・枝豆' }
    self_introduce { 'テストですー' }
  end
end

