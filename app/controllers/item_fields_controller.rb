class ItemFieldsController < ApplicationController
  before_action :set_item_field, only: [:show, :edit, :update, :destroy]

  def index
    @item_fields = ItemField.all
  end

  def show
  end

  def new
    @item_field = ItemField.new
  end

  def create
    @item_field = ItemField.new(item_field_params)
    if @item_field.save
      redirect_to @item_field, notice: 'Item field was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @item_field.update(item_field_params)
      redirect_to @item_field, notice: 'Item field was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @item_field.destroy
    redirect_to item_fields_url, notice: 'Item field was successfully destroyed.'
  end

  private

  def set_item_field
    @item_field = ItemField.find(params[:id])
  end

  def item_field_params
    params.require(:item_field).permit(:collection_id, :field_name, :field_type)
  end
end
