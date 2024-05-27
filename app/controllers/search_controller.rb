class SearchController < ApplicationController
  def index
    query = params[:query]
    @items = Item.search_full_text(query)
    @collections = Collection.search_full_text(query)
  end
end
