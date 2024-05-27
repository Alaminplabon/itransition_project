#Item.create!(name: "Item 1", collection_id: 14,hash_tag: "plabon")

t = Tag.create(name:'hello')
i = Item.create!(name: "Item 11", collection_id: 14)
ItemTag.create!(item: i, tag: t)