class Audio < ActiveRecord::Base
  mount_uploader :uploaded_file, AudioUploader

  has_many :listens
  belongs_to :category

  validates :name, presence: true

  enum status: [:draft, :approved]
end
