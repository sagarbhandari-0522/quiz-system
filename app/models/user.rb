# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise m odules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: [:google_oauth2]
  def self.from_omniauth(auth)
    user = User.find_by(email: auth.info.email)
    if user
      user.provider = auth.provider
      user.uid = auth.uid
      user.save!
    else
      user = User.where(provider: auth.provider, uid: auth.uid).first_or_create! do |user_gmail|
        user_gmail.email = auth.info.email
        user_gmail.password = Devise.friendly_token[0, 20]
      end
    end
    user
  end
  enum role: { user: 0, admin: 1 }
  has_many :quizzes, dependent: :destroy
  has_many :notifications, as: :recipient, dependent: :destroy
end
