class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable

  include DeviseTokenAuth::Concerns::User

  after_create :send_confirmation_email, if: -> { !Rails.env.test? && User.devise_modules.include?(:confirmable) }

  has_many :listens
  has_many :likes

  enum role: [:normal_user, :special_user, :admin]

  private
  def send_confirmation_email
    self.send_confirmation_instructions
  end
end
