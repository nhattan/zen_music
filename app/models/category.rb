class Category < ActiveRecord::Base
  mount_uploader :thumbnail, ThumbnailUploader
  extend ActsAsTree::TreeWalker
  extend ActsAsTree::TreeView

  acts_as_tree order: "name"
  acts_as_paranoid

  validates :name, presence: true, uniqueness: true

  has_many :audios, dependent: :destroy

  scope :limited_access, -> { where(limited_access: true) }
  scope :normal, -> { where(limited_access: false) }

  def path_name
    if root?
      name
    else
      category = self
      names = [name]
      while category.parent do
        names << category.parent.name
        category = category.parent
      end
      names.reverse.join(" . ")
    end
  end

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

  def as_json(options = nil)
    {
      id: id,
      name: name,
      description: description,
      limited_access: limited_access,
      created_at: created_at,
      updated_at: updated_at,
      parent_id: parent_id,
      thumbnails: thumbnails,
      audios: approved_audios,
      children: children
    }
  end
end
