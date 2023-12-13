extends PanelContainer

@export var debug_messages_on: bool = false

@onready var helmet_slot = %HelmetSlot
@onready var chest_slot = %ChestSlot
@onready var arm_slot = %ArmSlot
@onready var legs_slot = %LegsSlot
@onready var ring_slot_1 = %RingSlot_1
@onready var ring_slot_2 = %RingSlot_2
@onready var necklace_slot = %NecklaceSlot
@onready var weapon_slot = %WeaponSlot
@onready var ability_slot_1 = %AbilitySlot_1
@onready var ability_slot_2 = %AbilitySlot_2
@onready var ability_slot_3 = %AbilitySlot_3
@onready var ability_slot_4 = %AbilitySlot_4

func set_panel_visible(state: bool):
	visible = state


func _on_weapon_slot_item_updated(current_item):
	if debug_messages_on:
		if current_item:
			print_debug("Changing weapon: " + current_item.item_resource.get_item_info())
		else:
			print_debug("Weapon removed")
	PlayerStats.set_weapon(current_item)


func _on_helmet_slot_item_updated(current_item):
	if debug_messages_on:
		if current_item:
			print_debug("Changing helmet: " + current_item.item_resource.get_item_info())
		else:
			print_debug("Helmet removed")
	PlayerStats.set_helmet(current_item)


func _on_chest_slot_item_updated(current_item):
	if debug_messages_on:
		if current_item:
			print_debug("Changing chestpiece: " + current_item.item_resource.get_item_info())
		else:
			print_debug("Chestpiece removed")
	PlayerStats.set_chestpiece(current_item)


func _on_arm_slot_item_updated(current_item):
	if debug_messages_on:
		if current_item:
			print_debug("Changing armpiece: " + current_item.item_resource.get_item_info())
		else:
			print_debug("Armpiece removed")
	PlayerStats.set_armpiece(current_item)


func _on_legs_slot_item_updated(current_item):
	if debug_messages_on:
		if current_item:
			print_debug("Changing legpiece: " + current_item.item_resource.get_item_info())
		else:
			print_debug("Legpiece removed")
	PlayerStats.set_legpiece(current_item)
