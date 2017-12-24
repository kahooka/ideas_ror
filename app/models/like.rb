class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :idea

  validates :user, uniqueness: { scope: :idea }
end
