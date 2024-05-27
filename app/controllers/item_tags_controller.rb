class ItemTagsController < ApplicationController
  before_action :set_item_tag, only: [:show, :edit, :update, :destroy]

  def index
    @item_tags = ItemTag.all
  end

  def show
  end

  def new
    @item_tag = ItemTag.new
  end

  def create
    @item_tag = ItemTag.new(item_tag_params)
    if @item_tag.save
      redirect_to @item_tag, notice: 'Item tag was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @item_tag.update(item_tag_params)
      redirect_to @item_tag, notice: 'Item tag was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @item_tag.destroy
    redirect_to item_tags_url, notice: 'Item tag was successfully destroyed.'
  end

  private

  def set_item_tag
    @item_tag = ItemTag.find(params[:id])
  end

  def item_tag_params
    params.require(:item_tag).permit(:item_id, :tag_id)
  end
end
