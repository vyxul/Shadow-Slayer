extends PanelContainer

signal selected

#@export var temp_item: Item
@export var is_draggable: bool = false
@export var is_editable: bool = false
@export var is_type_required: bool = false
@export_group("Item Type Required")
@export var item_type_required: ItemTypeEnums.ItemType
@export var weapon_type_required: ItemTypeEnums.WeaponType
@export var armor_type_required: ItemTypeEnums.ArmorType
@export var accessory_type_required: ItemTypeEnums.AccessoryType

@onready var item_sprite = %ItemSprite
@onready var border_rect = $BorderRect
@onready var fill_rect = $BorderRect/FillRect

var slot_empty: bool = true
var current_item: Item = null

var is_weapon_resource: bool = false
var is_armor_resource: bool = false
var is_accessory_resource: bool = false
var is_ability_resource: bool = false

func _ready():
	item_sprite.texture = null
	fill_rect.color = Color.GRAY
	border_rect.color = Color.BLACK
#	set_item(temp_item)
	pass


func set_item(item: Item):
	current_item = item as Item
	item_sprite.texture = item.item_resource.icon_texture
	slot_empty = false
	fill_rect.color = Color.WHITE
	
	var item_resource = current_item.item_resource
	if item_resource is WeaponResource:
#		print_debug("item resource counts as weapon resource")
		border_rect.color = Color.DARK_RED
		is_weapon_resource = true


# function that executes when draggin from this slot
func _get_drag_data(at_position):
	if !is_draggable:
		return
	
	var texture = item_sprite.texture
	
	var preview_texture = TextureRect.new()
	preview_texture.texture = texture
	preview_texture.expand_mode = 1
	preview_texture.size = Vector2(30,30)
	
	var preview = Control.new()
	preview.add_child(preview_texture)
	set_drag_preview(preview)
	
	return current_item


# function that returns if this slot will accept dropped data
func _can_drop_data(at_position, data):
	# if this slot does not accept being dropped data then return false
	if !is_editable:
		return false

	# if this slot does not require a specific type of item then return true
	if !is_type_required:
		return true
	
	# check if the item resource types matches this slots requirements
	var item_resource = data.item_resource
	var item_type = item_resource.item_type
	# if the main category doesn't match
	if item_type != item_type_required:
		return false
		
	# need to check if sub item type was specified
	# for now just need armor to match
	match(item_type_required):
		ItemTypeEnums.ItemType.Armor:
			return false
		_:
			return true


# function that executes when accepting dropped data
func _drop_data(at_position, data):
	set_item(data)


func _on_gui_input(event: InputEvent):
	if event.is_action_pressed("left_click"):
		if current_item:
			var item_resource = current_item.item_resource
			print_debug(item_resource.get_item_info())
			selected.emit()


func _on_mouse_entered():
	GameEvents.mouse_entered_ui()


func _on_mouse_exited():
	GameEvents.mouse_exited_ui()