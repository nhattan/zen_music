class Category < ActiveRecord::Base
  mount_uploader :thumbnail, ThumbnailUploader
  extend ActsAsTree::TreeWalker
  extend ActsAsTree::TreeView

  acts_as_tree order: "name"

  validates :name, presence: true, uniqueness: true

  has_many :audios

  scope :limited_access, -> { where(limited_access: true) }
  scope :normal, -> { where(limited_access: false) }

  def approved_audios
    audios.approved
  end

  def thumbnails
    {
      original: { url: thumbnail.url },
      medium: { url: thumbnail.url(:medium) },
      small: { url: thumbnail.url(:small) },
      smaller: { url: thumbnail.url(:smaller) }
    }
  end
end
