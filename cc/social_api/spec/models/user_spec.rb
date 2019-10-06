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

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  context 'username uniqueness' do
    it 'is not valid if the username is already taken' do
      create(:user, username: 'john123')

      new_user = build(:user, username: 'john123')
      expect(new_user).not_to be_valid
      expect(new_user.errors.full_messages.to_sentence).to match /Username has already been taken/
    end
  end
end
