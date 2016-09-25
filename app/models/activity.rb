class Activity < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :subject, polymorphic: true
  belongs_to :user

  scope :likes, -> do
    where(subject_type: 'Like')
  end

  scope :listens, -> do
    where(subject_type: 'Listen')
  end
end
