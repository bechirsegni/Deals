class User < ApplicationRecord
  ratyrate_rater
  acts_as_voter

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "70x70>" }, :unless => "avatar.blank?",
                    default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

  has_many :articles
  has_many :categories
  has_many :deals
  has_many :reviews
  has_many :coupons

  validates :email, :uniqueness => :true

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.avatar = auth.info.image
      user.password = Devise.friendly_token[0,20]
      user.username = user.email.split("@").first
      user.gender = user.gender
    end
  end

  def preloaded_votes(votable)
    @preloaded_votes ||= Vote.where(voter: self, votable: votable).group(:votable_id).count
  end

  def full_name
    [first_name , last_name].join(' ')
  end

  def user_name
    self.email.split('@').first
  end
end
