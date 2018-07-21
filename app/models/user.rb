class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable #, :omniauthable, omniauth_providers: %i[facebook]
         
  devise :omniauthable, omniauth_providers: %i[facebook]
         
  has_many :user_projects
  has_many :projects, through: :user_projects
  
  validates :name, presence: true, uniqueness: true
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.image = auth.info.image
    end
  end
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

end
