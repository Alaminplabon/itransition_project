class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session
  load_and_authorize_resource except: [:display_tags, :remove_dynamic_fields]
  def index
    @items = Item.all
    @collections = Collection.all
    @tags = Tag.all
  end

  def show
    @collection = Collection.find_by(id: params[:collection_id])
    @item = @collection.items.find_by(id: params[:id])
    @comment = @item.comments.new
    @likes = @item.likes
  end

  def new
    @collection = Collection.find_by(id: params[:collection_id])
    @item = @collection.items.new
    @tags = Tag.all
  end

  def create
    tags = JSON.parse(params[:item][:tags])
    tag_objects = tags.map do |tag_name|
      Tag.find_or_create_by(name: tag_name)
    end
    collection_id = params[:collection_id].to_i
    @item = Item.new(item_params)
    @item.collection_id = collection_id
    @item.user = current_user
    @item.tags = tag_objects
    @item.dynamic_fields = params[:item].except('name', 'tags')

    if @item.save
      redirect_to collection_path(@item.collection), notice: 'Item was successfully created.'
    else
      render :new
    end
  end

  def edit
    @collection = Collection.find_by(id: params[:collection_id])
    @item = @collection.items.find_by(id: params[:id])
  end

  def update
    @item = Item.find_by(id: params[:id])
    if params[:item][:tags]
      tags = JSON.parse(params[:item][:tags])
      tag_objects = tags.map do |tag_name|
        Tag.find_or_create_by(name: tag_name)
      end
      @item.tags = tag_objects
    end
    @item.name = item_params[:name]
    collection_id = params[:collection_id].to_i
    @item.collection_id = collection_id
    @item.user = current_user
    @item.dynamic_fields = params[:item].except('name', 'tags')

    if @item.save
      redirect_to collection_path(@item.collection), notice: 'Item was successfully updated.'
    else
      render :new
    end
  end

  def destroy
    @item.destroy
    collection = @item.collection
    redirect_to collection_path(collection), notice: 'Item was successfully destroyed.'
  end

  def remove_dynamic_fields
    collection = Collection.find_by(id: params[:id])

    if collection.nil?
      redirect_to collections_path, alert: 'Collection not found'
      return
    end

    if collection.dynamic_field.key?(params[:key])
      collection.dynamic_field.delete(params[:key])
      if collection.save
        redirect_to collection_path(collection), notice: 'Dynamic field removed successfully'
      else
        redirect_to collection_path(collection), alert: 'Failed to remove dynamic field'
      end
    else
      redirect_to collection_path(collection), alert: 'Key not found in dynamic fields'
    end
  end

  def display_tags
    @tag = Tag.find_by(id: params[:id])
    @items = @tag.items
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name)
  end
end
