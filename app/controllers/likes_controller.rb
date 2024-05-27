class LikesController < ApplicationController

  def create
    collection = Collection.find_by(id: params[:collection_id])
    item = collection.items.find_by(id: params[:item_id])
    like = item.likes.new
    like.user = current_user

    if like.save
      redirect_to collection_item_path(collection, item), notice: 'Like was successfully created.'
    else
      redirect_to collection_item_path(collection, item), alert: 'Unable to create like.'
    end
  end

  # def destroy
  #   @like.destroy
  #   redirect_to @like.item, notice: 'Like was successfully destroyed.'
  # end

  private

  def like_params
    params.require(:like).permit(:item_id, :user_id)
  end
end
