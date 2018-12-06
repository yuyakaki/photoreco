class Post < ApplicationRecord
  belongs_to :user
  
  has_many :comments, dependent: :destroy  
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes
  
  mount_uploader :image_name, ImageUploader
  
  validates :user, presence: true
  validates :title, presence: true, length: { maximum: 20 }
  validates :content, presence: true, length: { maximum: 1000 }

  
end
