class Like < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :user
  belongs_to :audio, counter_cache: true

  validates :audio_id, uniqueness: { scope: :user_id,
    message: "is already liked" }
end
