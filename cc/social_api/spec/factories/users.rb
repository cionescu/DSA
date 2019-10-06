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

FactoryBot.define do
  factory :user do
    name { FFaker::Name.unique.name }
    username { FFaker::Internet.unique.user_name }
  end
end
