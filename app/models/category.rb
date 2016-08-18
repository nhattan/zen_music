class Category < ActiveRecord::Base
  mount_uploader :thumbnail, ThumbnailUploader

  validates :name, presence: true, uniqueness: true

  has_many :audios

  scope :limited_access, -> { where(limited_access: true) }
end
