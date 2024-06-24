class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable
         #:recoverable, :rememberable
         
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post
  has_many :comments, dependent: :destroy
  has_many :post_members, dependent: :destroy
  has_many :member_posts, through: :post_members, source: :post
  has_one_attached :profile_image
  
  def favorite(post)
    self.favorites.find_or_create_by(post_id: post.id)
  end
  
  def unfavorite(post)
    favorite = self.favorites.find_by(post_id: post.id)
    favorite.destroy if favorite
  end
  
  def favorite?(post)
    self.favorite_posts.include?(post)
  end
  
  def join_member(post)
    self.post_members.find_or_create_by(post_id: post.id)
  end
  
  def detach_member(post)
    post_member = self.post_members.find_by(post_id: post.id)
    post_member.destroy if post_member
  end
  
  def is_applying?(post)
    post_member = self.post_members.find_by(post_id: post.id)
    post_member && post_member.status == "applying"
  end
  
  def is_permitted?(post)
    post_member = self.post_members.find_by(post_id: post.id)
    post_member && post_member.status == "permitted"
  end
  
  def is_excluded?(post)
    post_member = self.post_members.find_by(post_id: post.id)
    post_member && post_member.status == "excluded"
  end
  
  def applying_post_members
    self.post_members.where(status: :applying)
  end
  
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
end
