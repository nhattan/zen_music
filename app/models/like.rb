class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :audio, counter_cache: true
end
