# == Schema Information
#
# Table name: followers
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  target_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_followers_on_target_id  (target_id)
#  index_followers_on_user_id    (user_id)
#

FactoryBot.define do
  factory :follower do
    association :user, strategy: :build
    association :target, factory: :user, strategy: :build
  end
end
