class Item < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_full_text, against: [:name],
                  associated_against: {
                    comments: [:content]
                  },
                  using: {
                    tsearch: { prefix: true,dictionary: 'simple' }
                  }

  scope :sorted, ->(sort_by, sort_direction) {
    order("#{sort_by } #{sort_direction}")
  }
  belongs_to :user
  belongs_to :collection
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :item_field_values, dependent: :destroy
  has_many :item_tags, dependent: :destroy
  has_many :tags, through: :item_tags
end
