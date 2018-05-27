# == Schema Information
#
# Table name: entities
#
#  id          :bigint(8)        not null, primary key
#  entity_type :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  entity_id   :bigint(8)
#
# Indexes
#
#  index_entities_on_entity_id  (entity_id)
#

class Entity < ApplicationRecord
  belongs_to :parent, class_name: 'Entity', foreign_key: 'entity_id'

  has_many :children, class_name: 'Entity', foreign_key: 'entity_id'
  has_many :reviews

  ENTITY_TYPES = %w( REGION AREA SHOP EMPLOYEE ).freeze

  validates :entity_type, inclusion: { in: ENTITY_TYPES }
  validates :entity_type, :name, presence: true
end
