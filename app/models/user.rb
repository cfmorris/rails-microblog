class User < ApplicationRecord
  attr_accessor :remember_token
  before_save {self.email = email.downcase}
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, 
                                    format: { with: VALID_EMAIL_REGEX },
                                    uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }
  
  
  # Generate the hash digest of a given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : 
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # returns a random token
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Stores a token in the digest for persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    if BCrypt::Password.new(remember_digest).is_password?(remember_token) ? true : false
    end
  end

  def forget
      self.update_attribute(:remember_digest, nil)
  end
end
