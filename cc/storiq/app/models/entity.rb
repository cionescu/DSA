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
  belongs_to :parent, class_name: 'Entity', foreign_key: 'entity_id', optional: true

  has_many :children, class_name: 'Entity', foreign_key: 'entity_id'
  has_many :reviews

  ENTITY_TYPES = %w( REGION AREA SHOP EMPLOYEE ).freeze

  validates :entity_type, inclusion: { in: ENTITY_TYPES }
  validates :entity_type, :name, presence: true

  scope :root, -> { where(entity_id: nil) }

  def average
    return "N/A" if reviews.none?
    reviews.pluck(:score).reduce(:+).to_f / reviews.count
  end

  def average_incl_children
    reviews = reviews_for(self)
    return "N/A" if reviews.none?
    reviews.map(&:score).reduce(:+).to_f / reviews.count
  end

  def reviews_for node
    reviews = node.reviews.to_a
    return reviews if node.children.none?
    node.children.each do |child|
      reviews << reviews_for(child)
    end
    reviews.flatten
  end
end
