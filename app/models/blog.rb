class Blog < ApplicationRecord
  has_many :match_drones, dependent: :destroy
  has_many :drones, through: :match_drones
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user

  enum pesticide_type: {
    "液剤":1,
    "液剤(肥料)":2,
    "粒剤":3,
    "粒剤(肥料)":4,
    "その他":5
  }, _prefix: true #その他が重複しても使用できるような接頭辞

  enum crop: {
    "稲":'1', "麦類":'2',"大豆":'3',"えだまめ":'4',"玉ねぎ":'5',
    "だいこん":'6',"キャベツ":'7',"はくさい":'8',"レタス":'9',"れんこん":'10',
    "にんじん":'11',"ブロッコリー":'12',"とうもろこし":'13',"まつ":'14',"果実類":'15',
    "その他野菜類":'16',"その他":'17'
  }, _prefix: true

  mount_uploader :picture, ImageUploader
end
