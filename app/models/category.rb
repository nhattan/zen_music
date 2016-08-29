class Category < ActiveRecord::Base
  mount_uploader :thumbnail, ThumbnailUploader
  extend ActsAsTree::TreeWalker
  extend ActsAsTree::TreeView
  include CustomThumbnailJson

  acts_as_tree order: "name"

  validates :name, presence: true, uniqueness: true

  has_many :audios

  scope :limited_access, -> { where(limited_access: true) }
end
