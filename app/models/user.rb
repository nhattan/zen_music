class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable

  include DeviseTokenAuth::Concerns::User

  after_create :send_confirmation_email

  private
  def send_confirmation_email
    self.send_confirmation_instructions
  end
end
