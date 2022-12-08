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
  has_many :comments, dependent: :destroy
  mount_uploader :icon, ImageUploader

  def favorited_by?(blog_id)
    favorites.where(blog_id: blog_id).exists?
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
    end
  end

  def self.guest_admin
    find_or_create_by!(email: 'guest_admin@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "管理者"
      user.admin = true
    end
  end
end
