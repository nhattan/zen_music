class Activity < ActiveRecord::Base
  belongs_to :subject, polymorphic: true
  belongs_to :user

  def is_like?
    name == "like"
  end

  def is_listen?
    name == "listen"
  end
end
