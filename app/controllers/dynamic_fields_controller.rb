class DynamicFieldsController < ApplicationController

  def create
    collection = Collection.find(id:params[:id])
    @dynamic_field =collection.dynamic_fields.new(dynamicfield_params)
    @dynamic_field.save
  end

  def new
    @dynamic_field = DynamicField.new
  end

  private
  def dynamicfield_params
    params.require(:dynamic_field).permit(:name, :field_type)
  end

end


