class User < ActiveRecord::Base
  #relationships
  has_many :ideas
  has_many :likes, dependent: :destroy
  has_many :ideas_liked, through: :likes, source: :idea

  # validations
  has_secure_password

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i    
  validates :name, :alias_name, presence: true, length: { in: 2..25 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }

  # before save
  before_save :email_lowercase
  before_save :alias_name_lowercase
  before_save :name_titleize

  def email_lowercase
    email.downcase!
  end

  def alias_name_lowercase
    alias_name.downcase!
  end

  def name_titleize
    name.titleize
  end

end
