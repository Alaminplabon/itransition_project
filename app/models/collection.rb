class Collection < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_full_text, against: [:name, :description],
                  using: {
                    tsearch: { prefix: true,dictionary: 'simple' }
                  }
  belongs_to :user
  has_many :items, dependent: :destroy
  has_many :item_fields
  has_many :dynamic_fields
  enum category: { books: 'Books', signs: 'Signs', silverware: 'Silverware', other: 'Other' }
  accepts_nested_attributes_for :dynamic_fields, allow_destroy: true
  validates :name, uniqueness: true
end
