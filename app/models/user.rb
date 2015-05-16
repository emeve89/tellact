class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :validatable

  has_many :stories

  after_save :ensure_authentication_token

  validates :username, :email, presence: true
  validates :access_token, uniqueness: true

  private

  def ensure_authentication_token
    if access_token.blank?
      self.access_token = generate_access_token
      save
    end
  end

  def generate_access_token
    loop do
      token = "#{self.id}:#{Devise.friendly_token}"
      break token unless User.find_by(access_token: token).present?
    end
  end
end
