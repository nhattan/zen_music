class Audio < ActiveRecord::Base
  mount_uploader :uploaded_file, AudioUploader

  belongs_to :category

  validates :name, presence: true

  enum status: [:draft, :approved]
end
