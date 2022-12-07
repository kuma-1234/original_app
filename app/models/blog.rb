class Blog < ApplicationRecord
  has_many :match_drones, dependent: :destroy
  has_many :drones, through: :match_drones
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user

  enum pesticide_type: {
    液剤: 1,
    液剤（肥料）: 2,
    粒剤: 3,
    粒剤（肥料）: 4,
    その他: 5
  }, _prefix: true #その他が重複しても使用できるような接頭辞

  enum crop: {
    稲: '稲', 麦類: '麦類', 大豆: '大豆', えだまめ: 'えだまめ', 玉ねぎ: '玉ねぎ',
    だいこん: 'だいこん', キャベツ: 'キャベツ', はくさい: 'はくさい', レタス: 'レタス', れんこん: 'れんこん',
    にんじん: 'にんじん', ブロッコリー: 'ブロッコリー', とうもろこし: 'とうもろこし', まつ: 'まつ', 果実類: '果樹類',
    その他野菜類: 'その他野菜類', その他: 'その他'
  }, _prefix: true

  enum status: { public: 0, private: 1}, _prefix: true

  mount_uploader :picture, ImageUploader
end
