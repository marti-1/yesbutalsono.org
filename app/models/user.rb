class User < ApplicationRecord

  has_many :propositions, foreign_key: :author_id

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # validate username presence and uniqueness
  validates :username, presence: true, uniqueness: true

  before_create :set_username

  private 

  def set_username
    tmp_username = build_tmp_username
    # Check if the username already exists
    while User.find_by(username: tmp_username)
      tmp_username = build_tmp_username
    end
    self.username = tmp_username
  end

  def build_tmp_username
    "#{self.email.split("@").first}-#{SecureRandom.random_number(1000)}"
  end
end
