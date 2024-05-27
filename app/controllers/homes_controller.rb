class HomesController < ApplicationController
  load_and_authorize_resource except: [:index]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
    def index
      @collections  = Collection.all.sort_by { |collection| collection.items.size }.reverse.take(5)
      @items = Item.all.limit(3).order(created_at: :desc)
      @tags = Tag.all
    end

    def show
    end

    def new
      @collection = Collection.find(params[:collection_id])
      @item =@collection.items.new
    end

    def create
      @item = Item.new(item_params)
      if @item.save
        redirect_to @item, notice: 'Item was successfully created.'
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @item.update(item_params)
        redirect_to @item, notice: 'Item was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @item.destroy
      redirect_to items_url, notice: 'Item was successfully destroyed.'
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
      params.require(:item).permit(:name, :collection_id)
    end
  end
