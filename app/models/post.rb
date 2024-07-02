class Post < ApplicationRecord
  attribute :tag_name, :string
  
  has_one_attached :image
  belongs_to :customer
  
  validates :title, presence: true
  validates :tag_name, presence: true
  
  after_validation :tag_validation
  after_save :update_post_tags
  after_find :to_tag_name
  
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
      image.variant(gravity: :center, resize: "#{width}x#{height}^", crop:"#{width}x#{height}+0+0").processed
  end
  
  has_many :favorites, dependent: :destroy
  has_many :favorite_customers, through: :favorites, source: :customer
  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :post_members, dependent: :destroy
  has_many :post_member_customers, through: :post_members, source: :customer
  
  private
  
  def tag_validation
    input_tags = self.tag_name.gsub(/[[:space:]]/, "").split(",").compact
    input_tags.each do |name|
      tag = Tag.find_or_initialize_by(name: name)
      if tag.new_record?
        if tag.invalid?
          errors.add(:tag_name, "error")
        end
      end
    end
  end
  
  def update_post_tags
    input_tags = self.tag_name.gsub(/[[:space:]]/, "").split(",").compact
    delete_tags = self.tags.pluck(:name) - input_tags
    input_tags.each do |name|
      tag = Tag.find_or_create_by(name: name)
      self.post_tags.find_or_create_by(tag_id: tag.id)
    end
    delete_tags.each do |name|
      tag = self.tags.find_by(name: name)
      post_tag_count = PostTag.where(tag_id: tag.id).size
      post_tag = self.post_tags.find_by(tag_id: tag.id)
      post_tag.destroy
      tag.destroy if post_tag_count <= 1
    end
  end
  
  def to_tag_name
    self.tag_name = self.tags.pluck(:name).join(", ")
  end
  
end