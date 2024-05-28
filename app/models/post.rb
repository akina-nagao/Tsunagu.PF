class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :customer
  
  validates :title, presence: true
  
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assetea/image/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
  
  has_many :favorites, dependent: :destroy
  has_many :favorite_customers, through: :favorites, source: :customer
  has_many :comments, dependent: :destroy
  
end
