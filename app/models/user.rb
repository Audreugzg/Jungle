class User < ActiveRecord::Base
  
  validates :first_name, :last_name, presence: true
  validates :email, presence: true
  validates :password, length: { minimum: 3 }
  validates :password_confirmation, length: { minimum: 3 }
  validates :email, uniqueness: { case_sensitive: false }
  before_save { email.downcase! }
  has_secure_password
  def self.authenticate_with_credentials(email, password)
    @user = User.find_by_email(email)

    if @user && @user.authenticate(password)
      return @user
    else
      return nil
    end
  end
end
