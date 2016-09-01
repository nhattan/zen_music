class Listen < ActiveRecord::Base
  belongs_to :user
  belongs_to :audio, counter_cache: true

  after_create :create_activity

  private
  def create_activity
    Activity.create(
      subject: self,
      name: 'listen',
      user: user
    )
  end
end
