extends PanelContainer

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
#	print_debug("Changing weapon: " + current_item.item_resource.get_item_info())
	PlayerStats.set_weapon(current_item)
#	print_debug("sending signal")
