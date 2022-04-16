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
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  def forget
      self.update_attribute(:remember_digest, nil)
  end
  
  def edit_profile(user)
    if user&.authenticate(params[:session][:password])
      if user.name != params[:new_name]
        user.update(name:params[:new_name]) ? flash[:success]="name updated" : flash[:danger]="name unsaved"
      end
      if params[:new_password] == params[:confirm_new_password] && !params[:new_password].nil?
        user.update(password:params[:new_password]) ? flash[:success]="password updated" : flash[:danger]="New password unsaved"
      end
      if user.email != params[:new_email]
        user.update(email:params[:new_email]) ? flash[:success]="email updated" : flash[:danger]="email unchanged"
      end
      flash[:warning]="Profile remains unchanged." if @user == User.find(params[:id])
    else
      flash[:danger]="Password invalid.  No changes saved."
    end
  end
end
