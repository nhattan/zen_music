class Like < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :user
  belongs_to :audio, counter_cache: true

  validates :audio_id, uniqueness: { scope: :user_id,
    message: "is already liked" }

  after_create :create_activity

  private
  def create_activity
    Activity.create(
      subject: self,
      name: 'like',
      user: user
    )
  end
end
