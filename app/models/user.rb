class User < ActiveRecord::Base
  has_many :microposts, dependent: :destroy
  before_save { self.email = email.downcase }
  #before_create :create_remember_token
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name,  presence: true, length: { maximum: 50 }

  def feed
    # このコードは準備段階です。
    # 完全な実装は、次回以降に行います。
    Micropost.where("user_id = ?", id)
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  # private

  #   def create_remember_token
  #     self.remember_token = User.encrypt(User.new_remember_token)
  #   end
end
