class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :api

  validates :firstname, :email, :password, presence: true
  validates :firstname, length: { minimum: 2 }
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 12 }
  validates :password, not_pwned: { on_error: :valid }
  validate :password_complexity

  def password_complexity
    return unless password.present? && !password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{12,}$/)

    errors.add :password, 'must include at least one lowercase letter, one uppercase letter, one digit, and needs to be minimum 12 characters.'
  end
end
