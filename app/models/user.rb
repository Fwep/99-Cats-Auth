class User < ApplicationRecord
  validates :username, :session_token, presence: true, uniqueness: true

  after_initialize :ensure_session_token

  def password=(password)
    @password = password
    self.password_dig
  end
  
  private

  def generate_session_token
    SecureRandom.urlsafe_base64
  end
  
  def reset_session_token!
    self.session_token = self.generate_session_token
    self.save!
  end
  
  def ensure_session_token
    self.session_token ||= self.generate_session_token
  end
end