class ItemFieldValuesController < ApplicationController
  before_action :set_item_field_value, only: [:show, :edit, :update, :destroy]

  def index
    @item_field_values = ItemFieldValue.all
  end

  def show
  end

  def new
    @item_field_value = ItemFieldValue.new
  end

  def create
    @item_field_value = ItemFieldValue.new(item_field_value_params)
    if @item_field_value.save
      redirect_to @item_field_value, notice: 'Item field value was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @item_field_value.update(item_field_value_params)
      redirect_to @item_field_value, notice: 'Item field value was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @item_field_value.destroy
    redirect_to item_field_values_url, notice: 'Item field value was successfully destroyed.'
  end

  private

  def set_item_field_value
    @item_field_value = ItemFieldValue.find(params[:id])
  end

  def item_field_value_params
    params.require(:item_field_value).permit(:item_id, :item_field_id, :value)
  end
end
