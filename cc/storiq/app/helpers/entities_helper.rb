module EntitiesHelper
  def entity_types parent
    types = Entity::ENTITY_TYPES
    return types unless parent
    # We only want to allow creation of children types
    types[types.index(parent.entity_type)+1 .. -1]
  end
end
