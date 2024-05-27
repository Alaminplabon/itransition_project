class ItemField < ApplicationRecord
  belongs_to :collection
  has_many :item_field_values, dependent: :destroy

  enum field_type: { integer: 'integer', string: 'string', text: 'text', boolean: 'boolean', date: 'date' }
end
