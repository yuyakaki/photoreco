class Post < ApplicationRecord
  belongs_to :user, optional: true
  
  mount_uploader :image_name, ImageUploader
  
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 1000 }
end
