class Listen < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :user
  belongs_to :audio, counter_cache: true

  after_create :create_activity
  after_destroy :destroy_activity

  private
  def create_activity
    Activity.create(
      subject: self,
      name: 'listen',
      user: user
    )
  end

  def destroy_activity
    activity = Activity.listens.find_by subject_id: id
    activity.destroy if activity
  end
end
