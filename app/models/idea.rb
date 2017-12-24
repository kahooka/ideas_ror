class Idea < ActiveRecord::Base
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_by, through: :likes, source: :user


  validates :content, presence: true


end
