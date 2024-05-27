class CollectionsController < ApplicationController
  before_action :set_collection, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session

  load_and_authorize_resource
  def index
    @collections = Collection.all.order(created_at: :desc)
  end

  def show
    sort_by = params.dig(:collection, :sort_by) || 'name'
    sort_direction = params.dig(:collection, :sort_direction) || 'asc'

    @collection = Collection.find(params[:id])
    @items = @collection.items.sorted(sort_by, sort_direction)
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Collection not found"
    redirect_to collections_path
  end
  def new
    @collection = Collection.new
    @collection.dynamic_fields.build
  end

  def create
    @collection = Collection.new(collection_params)
    if collection_params[:dynamic_field].present?
      dynamic_values = JSON.parse(collection_params[:dynamic_field])
      dynamic_values.each do |fields|
          @collection.dynamic_field = fields
      end
    end
    @collection.user = current_user
    @collection.category = 'books'
    if @collection.save
      redirect_to @collection, notice: 'Collection was successfully created.'
    else
      redirect_to '/profile', alert: 'Duplicate collection name found'
    end
  end

  def edit
  end

  def update
    if collection_params[:dynamic_field].present?
      dynamic_values = JSON.parse(collection_params[:dynamic_field])
      dynamic_values.each do |fields|
        fields.each do |key, value|
          @collection.dynamic_field.store(key,value)
        end
      end
    end
    if collection_params.present?
      @collection.update_columns(
        name: collection_params[:name],
        description: collection_params[:description],
        category: collection_params[:category],
        image_url: collection_params[:image_url],
      )
    end
    if @collection.save
      redirect_to @collection, notice: 'Collection was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @collection.destroy
    redirect_to collections_url, notice: 'Collection was successfully destroyed.'
  end

  private

  def set_collection
    @collection = Collection.find(params[:id])
  end

  def collection_params
    params.require(:collection).permit(:name, :description, :category, :image_url, :dynamic_field)
  end
end
# @collection.user=current_user