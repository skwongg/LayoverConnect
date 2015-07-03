class User < ActiveRecord::Base
  # Include default devise modules.
  # devise :database_authenticatable, :registerable,
  #         :recoverable, :rememberable, :trackable, :validatable,
  #         :confirmable, :omniauthable
  # include DeviseTokenAuth::Concerns::User
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :appointments
  has_many :businesses, through: :appointments
  validates :email, uniqueness: true
  # validates :password_confirmation, :presence => true, :if => '!password.nil?'
  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def authenticate(password)
    self.password == password
  end

  def validate_password_length(password)
    if password.length == 0
      self.errors[:base] << "Password can't be blank"
    elsif password.length <8
      self.errors[:base] << "Password needs to be at least 8 characters long"
    end
  end

########################
def self.find_or_create_from_auth_hash(auth_hash)
    uid = auth_hash['uid']
    provider = auth_hash['provider']

    user = find_or_create_by(uid: uid, provider: provider)

    user.username = auth_hash['info']['name'] || ''
    user.email = auth_hash['info']['email']
    # user.nickname = auth_hash['info']['nickname']
    user.profile_picture = auth_hash['info']['image'] || ''

    user.oauth_token = auth_hash['credentials']['token']

    # user.location = auth_hash['extra']['raw_info']['location'] || ''
    # user.company = auth_hash['extra']['raw_info']['company'] || ''
    # user.member_since = auth_hash['extra']['raw_info']['created_at'] || ''

    user if user.save
  end
########################




  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid      = auth.uid
      user.email    = auth.info.email
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.profile_picture = auth.info.image
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
end
