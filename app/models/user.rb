class User < ApplicationRecord

  has_many :propositions, foreign_key: :author_id

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  # validate username presence and uniqueness
  validates :username, presence: true, uniqueness: true

  before_validation :set_random_username, if: :new_record?

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.username = build_random_username(user.email)
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  protected

  def build_random_username email
    tmp_username = build_tmp_username(email)
    # Check if the username already exists
    while User.find_by(username: tmp_username)
      tmp_username = build_tmp_username(email)
    end
    tmp_username
  end

  def build_tmp_username email
    "#{email.split("@").first}-#{SecureRandom.random_number(1000)}"
  end

  def set_random_username
    self.username = build_random_username(self.email)
  end

end
