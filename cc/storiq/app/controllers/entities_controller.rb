class EntitiesController < ApplicationController
  def index
    @root_entities = Entity.root
    @entity = Entity.new
  end
end
