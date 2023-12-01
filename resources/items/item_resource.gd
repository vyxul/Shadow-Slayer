extends Resource
class_name ItemResource

enum ItemRarity {COMMON, UNCOMMON, RARE, EPIC, LEGENDARY, MYTHIC}

@export var item_type: ItemTypeEnums.ItemType
@export var icon_texture: Texture
@export var item_rarity: ItemRarity
@export var item_id: int

@export_group("Item Details")
@export var item_name: String
@export_multiline var item_description: String


func get_item_info() -> String:
	var return_string = "(Item ID: %d, Item Name: %s)" % [item_id, item_name]
	
	return return_string
