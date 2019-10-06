# == Schema Information
#
# Table name: followers
#
#  id          :integer          not null, primary key
#  user_id     :integer          not null
#  follower_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_followers_on_follower_id  (follower_id)
#  index_followers_on_user_id      (user_id)
#

FactoryBot.define do
  factory :follower do
    user { nil }
    follower_id { 1 }
  end
end
