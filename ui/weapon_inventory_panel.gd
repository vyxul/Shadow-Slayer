extends PanelContainer

@onready var weapon_grid_container = %Weapon_GridContainer
@onready var armor_grid_container = $MarginContainer/VBoxContainer/TabContainer/Armor/MarginContainer/Armor_GridContainer
@onready var accessory_grid_container = $MarginContainer/VBoxContainer/TabContainer/Accessories/MarginContainer/Accessory_GridContainer
@onready var ability_grid_container = $MarginContainer/VBoxContainer/TabContainer/Abilities/MarginContainer/Ability_GridContainer

var item_slot_scene = preload("res://ui/item_slot.tscn")
# can change this to be whatever looks good, 35 will fill whole panel
var panel_fill_count = 35
# 5 will fill row of panel
var panel_row_fill_count = 5

func _ready():
	generate_inventory_display()


# the generate_*_inventory func all work similarly
func generate_weapon_inventory():
	# first clear what we have already
	for child in weapon_grid_container.get_children():
		child.queue_free()
		
	# Weapon Inventory
	# add the displays for each item in inventory
	for item in PlayerInventory.get_weapon_inventory():
		var item_slot_instance = item_slot_scene.instantiate()
		weapon_grid_container.add_child(item_slot_instance)
		item_slot_instance.set_item(item)
		item_slot_instance.is_draggable = true
		
	# add slots to reach minimum number to fill panel out
	var weapon_slot_count = PlayerInventory.weapon_inventory.size()
	# if number of weapons in inventory <= set minimum slot count
	if weapon_slot_count <= panel_fill_count:
		var slots_to_add = panel_fill_count - weapon_slot_count
		for i in range(slots_to_add):
			var item_slot_instance = item_slot_scene.instantiate()
			weapon_grid_container.add_child(item_slot_instance)
	# if number of weapons in inventory > set minimum slot count
	# make sure the row it ends on is filled all the way
	else:
		# check if it already fills the row
		var keep_adding: bool = !((weapon_slot_count % panel_row_fill_count) == 0)
		while (keep_adding):
			var item_slot_instance = item_slot_scene.instantiate()
			weapon_grid_container.add_child(item_slot_instance)
			
			weapon_slot_count += 1
			keep_adding = !((weapon_slot_count % panel_row_fill_count) == 0)


func generate_armor_inventory():
	# first clear what we have already
	for child in armor_grid_container.get_children():
		child.queue_free()
		
	# Armor Inventory
	# add the displays for each item in inventory
	for item in PlayerInventory.get_armor_inventory():
		var item_slot_instance = item_slot_scene.instantiate()
		armor_grid_container.add_child(item_slot_instance)
		item_slot_instance.set_item(item)
		item_slot_instance.is_draggable = true
		
	# add slots to reach minimum number to fill panel out
	var armor_slot_count = PlayerInventory.armor_inventory.size()
	# if number of armor in inventory <= set minimum slot count
	if armor_slot_count <= panel_fill_count:
		var slots_to_add = panel_fill_count - armor_slot_count
		for i in range(slots_to_add):
			var item_slot_instance = item_slot_scene.instantiate()
			armor_grid_container.add_child(item_slot_instance)
	# if number of weapons in inventory > set minimum slot count
	# make sure the row it ends on is filled all the way
	else:
		# check if it already fills the row
		var keep_adding: bool = !((armor_slot_count % panel_row_fill_count) == 0)
		while (keep_adding):
			var item_slot_instance = item_slot_scene.instantiate()
			armor_grid_container.add_child(item_slot_instance)
			
			armor_slot_count += 1
			keep_adding = !((armor_slot_count % panel_row_fill_count) == 0)


func generate_accessory_inventory():
	# first clear what we have already
	for child in accessory_grid_container.get_children():
		child.queue_free()
		
	# Accessory Inventory
	# add the displays for each item in inventory
	for item in PlayerInventory.get_accessory_inventory():
		var item_slot_instance = item_slot_scene.instantiate()
		accessory_grid_container.add_child(item_slot_instance)
		item_slot_instance.set_item(item)
		item_slot_instance.is_draggable = true
		
	# add slots to reach minimum number to fill panel out
	var accessory_slot_count = PlayerInventory.accessory_inventory.size()
	# if number of accessories in inventory <= set minimum slot count
	if accessory_slot_count <= panel_fill_count:
		var slots_to_add = panel_fill_count - accessory_slot_count
		for i in range(slots_to_add):
			var item_slot_instance = item_slot_scene.instantiate()
			accessory_grid_container.add_child(item_slot_instance)
	# if number of weapons in inventory > set minimum slot count
	# make sure the row it ends on is filled all the way
	else:
		# check if it already fills the row
		var keep_adding: bool = !((accessory_slot_count % panel_row_fill_count) == 0)
		while (keep_adding):
			var item_slot_instance = item_slot_scene.instantiate()
			accessory_grid_container.add_child(item_slot_instance)
			
			accessory_slot_count += 1
			keep_adding = !((accessory_slot_count % panel_row_fill_count) == 0)


func generate_ability_inventory():
	# first clear what we have already
	for child in ability_grid_container.get_children():
		child.queue_free()
		
	# Ability Inventory
	# add the displays for each item in inventory
	for item in PlayerInventory.get_ability_inventory():
		var item_slot_instance = item_slot_scene.instantiate()
		ability_grid_container.add_child(item_slot_instance)
		item_slot_instance.set_item(item)
		item_slot_instance.is_draggable = true
		
	# add slots to reach minimum number to fill panel out
	var ability_slot_count = PlayerInventory.ability_inventory.size()
	# if number of abilities in inventory <= set minimum slot count
	if ability_slot_count <= panel_fill_count:
		var slots_to_add = panel_fill_count - ability_slot_count
		for i in range(slots_to_add):
			var item_slot_instance = item_slot_scene.instantiate()
			ability_grid_container.add_child(item_slot_instance)
	# if number of weapons in inventory > set minimum slot count
	# make sure the row it ends on is filled all the way
	else:
		# check if it already fills the row
		var keep_adding: bool = !((ability_slot_count % panel_row_fill_count) == 0)
		while (keep_adding):
			var item_slot_instance = item_slot_scene.instantiate()
			ability_grid_container.add_child(item_slot_instance)
			
			ability_slot_count += 1
			keep_adding = !((ability_slot_count % panel_row_fill_count) == 0)


func generate_inventory_display():
	generate_weapon_inventory()
	generate_armor_inventory()
	generate_accessory_inventory()
	generate_ability_inventory()


func set_panel_visible(state: bool):
	visible = state
