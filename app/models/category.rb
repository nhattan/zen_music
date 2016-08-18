class Category < ActiveRecord::Base
  mount_uploader :thumbnail, ThumbnailUploader

  validates :name, presence: true, uniqueness: true

  has_many :audios
end
