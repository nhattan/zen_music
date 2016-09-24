class Audio < ActiveRecord::Base
  acts_as_paranoid
  mount_uploader :uploaded_file, AudioUploader
  include CustomThumbnailJson

  has_many :listens
  has_many :likes
  belongs_to :category

  delegate :thumbnail, to: :category

  validates :name, presence: true

  enum status: [:draft, :approved]

  scope :top, -> { Audio.approved.order("listens_count desc") }
end
