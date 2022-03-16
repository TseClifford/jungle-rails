class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true, length: { minimum: 6 }
  before_save :downcase_email

  def self.authenticate_with_credentials(email, password)
    email = email.strip.downcase # remove whitespace and case sensitivity
    user = User.find_by(email: email)
    user && user.authenticate(password) ? user : nil
  end

  def downcase_email
    self.email.downcase!
  end
end
