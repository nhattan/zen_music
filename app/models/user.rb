class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable

  include DeviseTokenAuth::Concerns::User

  before_create :set_plan_expires_in
  after_create :send_confirmation_email, if: -> { User.devise_modules.include?(:confirmable) }

  has_many :listens
  has_many :likes
  has_many :activities

  enum role: [:normal_user, :special_user, :admin]

  scope :confirmed, -> { where.not(confirmed_at: nil) }

  def plan_is_expired?
    !!plan_expires_in && plan_expires_in <= Time.current
  end

  def favorite_audios
    audio_ids = likes.pluck(:audio_id)
    Audio.approved.where(id: audio_ids)
  end

  def update_plan_expires_in! duration
    if plan_expires_in && plan_expires_in > Time.current
      self.plan_expires_in = plan_expires_in + duration
    elsif (plan_expires_in && plan_expires_in <= Time.current) || plan_expires_in.nil?
      self.plan_expires_in = Time.current + duration
    end
    save!
  end

  private
  def send_confirmation_email
    send_confirmation_instructions
  end

  def set_plan_expires_in
    self.plan_expires_in = Time.current
  end
end
