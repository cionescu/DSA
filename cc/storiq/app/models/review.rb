# == Schema Information
#
# Table name: reviews
#
#  id         :bigint(8)        not null, primary key
#  score      :integer
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  entity_id  :bigint(8)
#
# Indexes
#
#  index_reviews_on_entity_id  (entity_id)
#
# Foreign Keys
#
#  fk_rails_...  (entity_id => entities.id)
#

class Review < ApplicationRecord
  belongs_to :entity

  validates :score, :title, presence: true
end
