class EntitiesController < ApplicationController
  def index
    @root_entities = Entity.root.includes(children: :reviews)
    @entity = Entity.new
  end

  def create
    @entity = Entity.create(entity_params)
    if @entity.persisted?
      redirect_to root_path, flash: { success: "The entity was successfully created" }
    else
      # Probably best to send to a #new page to edit. Not sure if in scope, so will just flash the errors
      redirect_to root_path, flash: { errors: @entity.errors.full_messages }
    end
  end

  private

  def entity_params
    params.require(:entity).permit(:entity_id, :name, :entity_type)
  end
end
