class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable

  include DeviseTokenAuth::Concerns::User

  after_create :send_confirmation_email, if: -> { !Rails.env.test? && User.devise_modules.include?(:confirmable) }

  has_many :listens
  has_many :likes

  enum role: [:normal_user, :special_user, :admin]

  def plan_is_expired?
    !!plan_expires_in && plan_expires_in <= Time.current
  end

  private
  def send_confirmation_email
    self.send_confirmation_instructions
  end
end
