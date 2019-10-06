# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  username   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_username  (username) UNIQUE
#

class User < ApplicationRecord
  has_many :followers

  validates :username, presence: true, uniqueness: true

  def follow target
    return false if follows?(target)
    followers.create(target: target)
  end

  def unfollow target
    return false unless follows?(target)
    followers.find_by(target: target).destroy
  end

  private

  def follows? target
    followers.find_by(target: target).present?
  end
end
