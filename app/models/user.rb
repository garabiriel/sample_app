class User < ActiveRecord::Base
  has_many :microposts, dependent: :destroy
  has_many :user_relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :user_relationships, source: :followed
  has_many :reverse_user_relationships, foreign_key: "followed_id", class_name:  "UserRelationship", dependent: :destroy
  has_many :followers, through: :reverse_user_relationships

  attr_accessible :email, :name, :password, :password_confirmation
  
  before_save { self.email = email.downcase }
  before_create :create_remember_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name,  presence: true, length: { maximum: 50 }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, confirmation:true, length: { minimum: 6 }
  after_validation { self.errors.messages.delete(:password_digest) }

  def feed
    Micropost.from_users_followed_by(self)
  end

  def following?(other_user)
    user_relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    user_relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    user_relationships.find_by_followed_id(other_user.id).destroy
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end
end