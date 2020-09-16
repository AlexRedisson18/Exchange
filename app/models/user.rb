class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  mount_uploader :avatar, AvatarUploader

  has_many :lots
  has_many :outgoing_offers, through: :lots
  has_many :incoming_offers, through: :lots
  has_many :messages, inverse_of: :user
  has_many :notifications
end
