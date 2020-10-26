class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :likes, dependent: :destroy
   has_many :like_users, through: :likes, source: :user
  
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :image,   content_type: { in: %w[image/jpeg image/png],
                                      message: "must be a valid image format" },
                      size:         { less_than: 5.megabytes,
                                      message: "should be less than 5MB" },
                                      presence: true
  
  def display_image
    image.variant(resize_to_fill: [230, 230])
  end
  
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
  
end
