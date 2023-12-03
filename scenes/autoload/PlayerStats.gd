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
	"armor_defense": 0,
	
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
	# remove the current weapon from dictionary and let
	# let the weapon controller handle the rest
	if item == null:
		equipment.current_weapon = null
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


func adjust_defenses(item: Item, equipping: bool = true):
	var item_resource = item.item_resource as ArmorResource
	# if the item passed in is not an armor resource then return
	if !item_resource is ArmorResource:
		print_debug("item was not ArmorResource")
		return
	
	# else it is an item and can adjust the stats
	var equip_control = 1 if equipping else -1
	var string = "Equipping: " if equipping else "Unequipping: "
	print_debug(string + item_resource.get_item_info())
	
	# manually add the stats from the item to the dictionary
	# using the equip_control as modifier for equipping/unequipping the stat changes
	defenses.armor_defense    += (equip_control * item_resource.armor_defense)
	defenses.physical_resist += (equip_control * item_resource.physical_resist)
	defenses.fire_resist      += (equip_control * item_resource.fire_resist)
	defenses.water_resist     += (equip_control * item_resource.water_resist)
	defenses.wind_resist      += (equip_control * item_resource.wind_resist)
	defenses.earth_resist     += (equip_control * item_resource.earth_resist)
	defenses.lightning_resist += (equip_control * item_resource.lightning_resist)
	defenses.ice_resist       += (equip_control * item_resource.ice_resist)
	defenses.light_resist     += (equip_control * item_resource.light_resist)
	defenses.dark_resist      += (equip_control * item_resource.dark_resist)
	defenses.slash_resist     += (equip_control * item_resource.slash_resist)
	defenses.pierce_resist    += (equip_control * item_resource.pierce_resist)
	defenses.blunt_resist     += (equip_control * item_resource.blunt_resist)
	
	print_debug("Defenses: " + str(defenses))


# set functions for all armors are pretty much the same, just keeping them as
# different names to make understanding how each one differs easier
func set_helmet(item: Item):
	# if item was removed from equipment screen
	# check if current armor slot had anything yet and if yes then remove stats
	# in any case, return after that check
	if item == null:
		if equipment.current_helmet:
			adjust_defenses(equipment.current_helmet, false)
			equipment.current_helmet = null
		return
	
	# check if passed in item is not armor
	var item_resource = item.item_resource
#	print_debug(item_resource.get_item_info())
	if !item_resource is ArmorResource:
		print_debug("failed armor_resource check")
		return
	
	# check if the passed in item is the same as current
	if equipment.current_helmet == item:
		print_debug("failed current_helmet check")
		return
	
	# at this point, it passed enough tests	
	# check if player had armor equipped already and remove the stats from it
	if equipment.current_helmet != null:
		adjust_defenses(equipment.current_helmet, false)
	
	# add the passed in armor to dictionary and add the stats
	equipment.current_helmet = item
	adjust_defenses(item)


func set_chestpiece(item: Item):
	# if item was removed from equipment screen
	# check if current armor slot had anything yet and if yes then remove stats
	# in any case, return after that check
	if item == null:
		if equipment.current_chestpiece:
			adjust_defenses(equipment.current_chestpiece, false)
			equipment.current_chestpiece = null
		return
	
	# check if passed in item is not armor
	var item_resource = item.item_resource
#	print_debug(item_resource.get_item_info())
	if !item_resource is ArmorResource:
		print_debug("failed armor_resource check")
		return
	
	# check if the passed in item is the same as current
	if equipment.current_chestpiece == item:
		print_debug("failed current_chestpiece check")
		return
	
	# at this point, it passed enough tests	
	# check if player had armor equipped already and remove the stats from it
	if equipment.current_chestpiece != null:
		adjust_defenses(equipment.current_chestpiece, false)
	
	# add the passed in armor to dictionary and add the stats
	equipment.current_chestpiece = item
	adjust_defenses(item)


func set_armpiece(item: Item):
	# if item was removed from equipment screen
	# check if current armor slot had anything yet and if yes then remove stats
	# in any case, return after that check
	if item == null:
		if equipment.current_armpiece:
			adjust_defenses(equipment.current_armpiece, false)
			equipment.current_armpiece = null
		return
	
	# check if passed in item is not armor
	var item_resource = item.item_resource
#	print_debug(item_resource.get_item_info())
	if !item_resource is ArmorResource:
		print_debug("failed armor_resource check")
		return
	
	# check if the passed in item is the same as current
	if equipment.current_armpiece == item:
		print_debug("failed current_armpiece check")
		return
	
	# at this point, it passed enough tests	
	# check if player had armor equipped already and remove the stats from it
	if equipment.current_armpiece != null:
		adjust_defenses(equipment.current_armpiece, false)
	
	# add the passed in armor to dictionary and add the stats
	equipment.current_armpiece = item
	adjust_defenses(item)


func set_legpiece(item: Item):
	# if item was removed from equipment screen
	# check if current armor slot had anything yet and if yes then remove stats
	# in any case, return after that check
	if item == null:
		if equipment.current_legpiece:
			adjust_defenses(equipment.current_legpiece, false)
			equipment.current_legpiece = null
		return
	
	# check if passed in item is not armor
	var item_resource = item.item_resource
#	print_debug(item_resource.get_item_info())
	if !item_resource is ArmorResource:
		print_debug("failed armor_resource check")
		return
	
	# check if the passed in item is the same as current
	if equipment.current_legpiece == item:
		print_debug("failed current_legpiece check")
		return
	
	# at this point, it passed enough tests	
	# check if player had armor equipped already and remove the stats from it
	if equipment.current_legpiece != null:
		adjust_defenses(equipment.current_legpiece, false)
	
	# add the passed in armor to dictionary and add the stats
	equipment.current_legpiece = item
	adjust_defenses(item)


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
