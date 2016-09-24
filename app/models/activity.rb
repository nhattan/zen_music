class Activity < ActiveRecord::Base
  belongs_to :subject, polymorphic: true
  belongs_to :user

  scope :without_unliked, -> do
    unliked_ids = Like.only_deleted.ids
    ids = where(subject_type: 'Like', subject_id: unliked_ids).ids
    where.not(id: ids)
  end
end
