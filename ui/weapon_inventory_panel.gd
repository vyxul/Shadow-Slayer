extends PanelContainer

@onready var weapon_grid_container = %Weapon_GridContainer

var item_slot_scene = preload("res://ui/item_slot.tscn")


func _ready():
	generate_weapon_inventory_display()


func generate_weapon_inventory_display():
	# first clear what we have already
	for child in weapon_grid_container.get_children():
		child.queue_free()
	
	# add the displays for each item
	for item in PlayerInventory.get_weapon_inventory():
		var item_slot_instance = item_slot_scene.instantiate()
		weapon_grid_container.add_child(item_slot_instance)
		item_slot_instance.set_item(item)
		item_slot_instance.is_draggable = true


func set_panel_visible(state: bool):
	visible = state
