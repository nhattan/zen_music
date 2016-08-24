class Like < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :user
  belongs_to :audio, counter_cache: true
end
