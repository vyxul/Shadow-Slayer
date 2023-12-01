extends Node

signal current_weapon_changed(item: Item)

@export var player_level: int = 1
@export var player_mana: int = 10
@export var player_damage_multiplier: float = 1.0

@export_group("Health Component Stats")
@export var max_hp: int = 10

## Flat defense value taken off the damage amount after resistances
@export_group("Armor Component Stats")
@export var defense: int = 0
# Percent of the damage reduced or added to the original damage amount
@export_subgroup("Damage Element Resistances")
@export_range(-1, 1) var physical_resist: float = 0
@export_range(-1, 1) var fire_resist: float = 0
@export_range(-1, 1) var water_resist: float = 0
@export_range(-1, 1) var wind_resist: float = 0
@export_range(-1, 1) var earth_resist: float = 0
@export_range(-1, 1) var lightning_resist: float = 0
@export_range(-1, 1) var ice_resist: float = 0
@export_range(-1, 1) var light_resist: float = 0
@export_range(-1, 1) var dark_resist: float = 0
@export_subgroup("Damage Type Resistances")
@export_range(-1, 1) var slash_resist: float = 0
@export_range(-1, 1) var pierce_resist: float = 0
@export_range(-1, 1) var blunt_resist: float = 0


# current equipped items
# Weapon
var current_weapon: Item = null

# Armor
var current_helmet: Item = null
var current_chestpiece: Item = null
var current_armpiece: Item = null
var current_legpiece: Item = null

# Accessories
var current_ring_1: Item = null
var current_ring_2: Item = null
var current_necklace: Item = null

# Abilities
var current_ability_1: Item = null
var current_ability_2: Item = null
var current_ability_3: Item = null
var current_ability_4: Item = null

# maybe have a big dictionary of all possible status effects here?
# items with status effects can have small dictionary paired with them
# and then adjust the corresponding dictionary key/value in player status effects
const status_effects = {}


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
	if current_weapon == item:
#		print_debug("failed current_weapon check")
		return
	
	# by this point, it passed all the checks, update the weapon
#	print_debug("passed set_weapon checks")
	current_weapon = item
	current_weapon_changed.emit(item)


# set up later when we have a save system
func save():
	pass


func load():
	pass
