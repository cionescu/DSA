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

require 'rails_helper'

RSpec.describe Follower, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
