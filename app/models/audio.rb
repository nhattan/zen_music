class Audio < ActiveRecord::Base
  acts_as_paranoid
  mount_uploader :uploaded_file, AudioUploader
  include CustomThumbnailJson

  has_many :listens
  has_many :likes
  belongs_to :category
  after_destroy :destroy_activities

  delegate :thumbnail, to: :category

  validates_presence_of :name, :description, :category_id, :uploaded_file

  enum status: [:draft, :approved]

  scope :top, -> { Audio.approved.order("listens_count desc") }

  def activities
    listen_ids = listens.ids
    like_ids = likes.ids
    Activity.listens.where(subject_id: listen_ids).or(Activity.likes.where(subject_id: like_ids))
  end

  def uploaded_file_extension
    uploaded_file.file.extension.downcase if uploaded_file && uploaded_file.file
  end

  def uploaded_file_url
    case uploaded_file_extension
    when 'mp3'
      "#{ENV['AWS_CLOUDFRONT_URL_STREAMING']}/cfx/st/mp3:#{uploaded_file.path[0..-5]}"
    when 'm4a'
      "#{ENV['AWS_CLOUDFRONT_URL_STREAMING']}/cfx/st/mp4:#{uploaded_file.path}"
    end
  end

  private

  def destroy_activities
    activities.destroy_all
  end
end
