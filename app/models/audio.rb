class Audio < ActiveRecord::Base
  mount_uploader :uploaded_file, AudioUploader

  has_many :listens
  has_many :likes
  belongs_to :category

  validates :name, presence: true

  enum status: [:draft, :approved]

  scope :top, -> { Audio.approved.order("listens_count desc") }
end
