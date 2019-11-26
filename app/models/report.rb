class Report < ApplicationRecord
  belongs_to :vessel
  has_many :progresses
  has_many :taskdets, dependent: :destroy
  has_one_attached :image
  default_scope -> {order(created_at: :desc)}
  validates :vessel_id, presence: true
  validates :lat, presence: true
  validates :lon, presence: true
  #validates :image, content_type: {in: %w[image/jpeg image/gif image/png], message: "must be a valid image format"},
  #                  size: { less_than: 5.megabytes, message: "should be less than 5MB"}

  #Return a resized image for display
  #def display_image
#    image.variant(resize_to_limit: [500,500])
#  end
end
