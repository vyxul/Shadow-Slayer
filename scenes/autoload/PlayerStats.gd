extends Node

signal current_weapon_changed(item: Item)

# general player stats
var stats = {
	# maybe have level affect damage by 5% per level?
	"level": 1,
	"max_hp": 10,
	"current_hp": 10,
	"max_mana": 10,
	"current_mana": 10,
	"move_speed": 120
}

# stats for reducing incoming damage
var defenses = {
	# flat amount taken away from damage after resistance calculation
	"defense": 0,
	
	# Resistances (-1 to 1)
	# Damage Element Resistances
	"physical_resist": 0,
	"fire_resist": 0,
	"water_resist": 0,
	"wind_resist": 0,
	"earth_resist": 0,
	"lightning_resist": 0,
	"ice_resist": 0,
	"light_resist": 0,
	"dark_resist": 0,
	# Damage Type Resistances
	"slash_resist": 0,
	"pierce_resist": 0,
	"blunt_resist": 0
}

# current equipped items
var equipment = {
	# Weapon
	"current_weapon": null,
	# Armor
	"current_helmet": null,
	"current_chestpiece": null,
	"current_armpiece": null,
	"current_legpiece": null,
	# Accessories
	"current_ring_1": null,
	"current_ring_2": null,
	"current_necklace": null,
	# Abilities
	"current_ability_1": null,
	"current_ability_2": null,
	"current_ability_3": null,
	"current_ability_4": null
}

# maybe have a big dictionary of all possible status effects here?
# items with status effects can have small dictionary paired with them
# and then adjust the corresponding dictionary key/value in player status effects
# can have a base of 1 for all and add/subtract when we set/remove equips
# maybe name this as multipliers and another dictionary for actual status affects
# (dots, time based buffs, etc)
var status_effects = {}


func set_weapon(item: Item):
	# if the weapon was removed from equip screen
	# let the weapon controller handle it
	if item == null:
		current_weapon_changed.emit(item)
		return
	
	# check if passed in item is not a weapon
	var item_resource = item.item_resource
#	print_debug(item_resource.get_item_info())
	if !item_resource is WeaponResource:
#		print_debug("failed weapon_resource check")
		return
	
	# check if the passed in item is the same as current
	if equipment.current_weapon == item:
#		print_debug("failed current_weapon check")
		return
	
	# by this point, it passed all the checks, update the weapon
#	print_debug("passed set_weapon checks")
	equipment.current_weapon = item
	current_weapon_changed.emit(item)

# need to make the rest of the setter for the equipment after i make the resources
func set_helmet(item: Item):
	pass

func set_chestpiece(item: Item):
	pass

func set_armpiece(item: Item):
	pass

func set_legpiece(item: Item):
	pass

func set_ring(item: Item, ring_slot: int):
	pass

func set_necklace(item: Item):
	pass

func set_ability(item: Item, ability_slot: int):
	pass

# set up later when we have a save system
func save():
	pass


func load():
	pass
