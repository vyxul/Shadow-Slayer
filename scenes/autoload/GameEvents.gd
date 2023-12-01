extends Node

# signals for changing player equipment
signal equipped_weapon_changed(item: Item)
signal equipped_armor_changed(item: Item, armor_slot: int)
signal equipped_accessory_changed(item: Item, accessory_slot: int)
signal equipped_ability_changed(item: Item, ability_slot: int)

# signals for when inventory changes to update the gui displays
signal weapon_inventory_updated
signal armor_inventory_updated
signal accessory_inventory_updated
signal ability_inventory_updated


var mouse_over_ui: bool = false
var mouse_overlapping_ui_count: int = 0


# Functions to signal that the players current equipment has changed
func emit_equipped_weapon_changed(item: Item):
	equipped_weapon_changed.emit(item)


func emit_equipped_armor_changed(item: Item, armor_slot: int):
	equipped_armor_changed.emit(item, armor_slot)


func emit_equipped_accessory_changed(item: Item, accessory_slot: int):
	equipped_accessory_changed.emit(item, accessory_slot)


func emit_equipped_ability_changed(item: Item, ability_slot: int):
	equipped_ability_changed.emit(item, ability_slot)


# Functions to signal that the players inventory has changed to alert GUI's
func emit_weapon_inventory_update():
	weapon_inventory_updated.emit()


func emit_armor_inventory_updated():
	armor_inventory_updated.emit()


func emit_accessory_inventory_updated():
	accessory_inventory_updated.emit()


func emit_ability_inventory_updated():
	ability_inventory_updated.emit()


func mouse_entered_ui():
	mouse_overlapping_ui_count += 1
	if mouse_overlapping_ui_count > 0:
		mouse_over_ui = true


func mouse_exited_ui():
	mouse_overlapping_ui_count -= 1
	if mouse_overlapping_ui_count <= 0:
		mouse_over_ui = false
