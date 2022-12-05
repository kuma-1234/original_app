class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
          
  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile
  has_many :blogs, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_blogs, through: :favorites, source: :blog

  def favorited_by?(blog_id)
    favorites.where(blog_id: blog_id).exists?
  end

  mount_uploader :icon, ImageUploader
end
