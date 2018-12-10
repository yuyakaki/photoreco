class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 10 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :content, length: { maximum: 255 }                  
  has_secure_password
  
  mount_uploader :image_name, ImageUploader

  has_many :posts, dependent: :destroy 
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
  has_many :comments, dependent: :destroy  
  has_many :likes, dependent: :destroy

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
    
    
  def like(post)
    self.likes.find_or_create_by(post_id: post.id)
  end

  def unlike(post)
    like = self.likes.find_by(post_id: post.id)
    like.destroy if like
  end
    
    
end
