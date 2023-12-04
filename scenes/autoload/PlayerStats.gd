extends Node

# stat signals
signal player_stats_changed
# hp signals
signal player_died
signal player_hp_lost(damage_taken: int, current_hp: int, max_hp: int)
signal player_hp_healed(health_healed: int, current_hp: int, max_hp: int)
signal player_hp_changed(current_hp: int, max_hp: int)
# mana signals
signal player_mana_empty
signal player_mana_lost(mana_used: int, current_mana: int, max_mana: int)
signal player_mana_gained(mana_gained: int, current_mana: int, max_mana: int)
signal player_mana_changed(current_mana: int, max_mana: int)

# equipment signals
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

# stat functions
# hp related functions
func get_current_hp() -> int:
	return stats.current_hp


func check_hp():
	# if hp at 0, send died signal for parent entity to queue free
	if stats.current_hp <= 0:
		player_died.emit()
		
	# clamp the current hp within bounds of 0 <--> max hp
	stats.current_hp = clamp(stats.current_hp, 0, stats.max_hp)
	player_stats_changed.emit()


# pass in the amount you want the max hp to change by
func change_max_hp(hp_amount: int):
	# if hp_amount is 0, then function has no use, return
	if hp_amount == 0:
		return
	
	stats.max_hp += hp_amount
	# ensure that max hp doesnt go below 1
	stats.max_hp = max(stats.max_hp, 1)
	# if max hp went up, make current hp go up by same amount
	if hp_amount > 0:
		stats.current_hp += hp_amount
		# check_hp shouldn't really do anything here but just leaving it just in case
		check_hp()
	# else max hp went down
	else:
		# if max hp < current hp, make current hp = max hp
		stats.max_hp += hp_amount
		if stats.max_hp < stats.current_hp:
			stats.current_hp = stats.max_hp
		# else leave current hp at where it is
		
	# emit signal that max hp changed
	player_hp_changed.emit(stats.current_hp, stats.max_hp)


func damage(damage_stats: Dictionary) -> int:
	print_debug("reached playerstats.damage()")
	var damage_amount  = damage_stats["damage"]
	var damage_element = damage_stats["damage_element"]
	var damage_type    = damage_stats["damage_type"]
	
#	print_debug("current hp = %d, damage = %d, damage_element = %d, damage_type = %d" \
#			   % [current_hp, damage_amount, damage_element, damage_type])
	
	var adjusted_damage_amount = damage_amount
	
	adjusted_damage_amount = adjust_damage(damage_stats)
#	print_debug("adjusted damage: %d" % adjusted_damage_amount)
	
	stats.current_hp -= adjusted_damage_amount
	check_hp()
	player_hp_lost.emit(adjusted_damage_amount, stats.current_hp, stats.max_hp)
	
	return adjusted_damage_amount


func heal(heal_amount: int):
	stats.current_hp += heal_amount
	check_hp()
	player_hp_healed.emit(heal_amount, stats.current_hp, stats.max_hp)

# mana related functions
func get_current_mana() -> int:
	return stats.current_mana


func check_mana():
	# if hp at 0, send died signal for parent entity to queue free
	if stats.current_mana <= 0:
		player_mana_empty.emit()
		
	# clamp the current hp within bounds of 0 <--> max hp
	stats.current_mana = clamp(stats.current_mana, 0, stats.max_mana)


# pass in the amount you want the max hp to change by
func change_max_mana(mana_amount: int):
	# if mana_amount is 0, then function has no use, return
	if mana_amount == 0:
		return
	
	stats.max_mana += mana_amount
	# ensure that max hp doesnt go below 0
	stats.max_mana = max(stats.max_mana, 0)
	# if max hp went up, make current hp go up by same amount
	if mana_amount > 0:
		stats.current_mana += mana_amount
		# check_hp shouldn't really do anything here but just leaving it just in case
		check_mana()
	# else max hp went down
	else:
		# if max hp < current hp, make current hp = max hp
		stats.max_mana += mana_amount
		if stats.max_mana < stats.current_mana:
			stats.current_mana = stats.max_mana
		# else leave current hp at where it is
		
	# emit signal that max hp changed
	player_mana_changed.emit(stats.current_mana, stats.max_mana)


# takes in only positive values to subtract from current mana
func mana_use(mana_use_amount: int):
	if mana_use_amount <= 0:
		return
	
	stats.current_mana -= mana_use_amount
	stats.current_mana = max(stats.current_mana, 0)
	if stats.current_mana == 0:
		player_mana_empty.emit()
		
	player_mana_lost.emit(mana_use_amount, stats.current_mana, stats.max_mana)


func mana_gain(mana_gain_amount: int):
	if mana_gain_amount <= 0:
		return
	
	stats.current_mana += mana_gain_amount
	stats.current_mana = min(stats.current_mana, stats.max_mana)
	
	player_mana_gained.emit(mana_gain_amount, stats.current_mana, stats.max_mana)


# calculates the incoming damage adjusted amount based on player defenses
func adjust_damage(damage_stats: Dictionary) -> int:
	var damage_amount  = damage_stats["damage"]
	var damage_element = damage_stats["damage_element"]
	var damage_type    = damage_stats["damage_type"]
	
	var adjusted_damage_amount = float(damage_amount)
	
	# get the elemental resistance of the armor for the incoming damage
	var element_resist = 0.0
	match(damage_element):
		DamageEnums.DamageElement.Physical:
			element_resist = defenses.physical_resist
		DamageEnums.DamageElement.Fire:
			element_resist = defenses.fire_resist
		DamageEnums.DamageElement.Water:
			element_resist = defenses.water_resist
		DamageEnums.DamageElement.Wind:
			element_resist = defenses.wind_resist
		DamageEnums.DamageElement.Earth:
			element_resist = defenses.earth_resist
		DamageEnums.DamageElement.Lightning:
			element_resist = defenses.lightning_resist
		DamageEnums.DamageElement.Ice:
			element_resist = defenses.ice_resist
		DamageEnums.DamageElement.Light:
			element_resist = defenses.light_resist
		DamageEnums.DamageElement.Dark:
			element_resist = defenses.dark_resist
			
	# get the type resistance of the armor for the incoming damage
	var type_resist = 0.0
	match(damage_type):
		DamageEnums.DamageType.Slash:
			element_resist = defenses.slash_resist
		DamageEnums.DamageType.Pierce:
			element_resist = defenses.pierce_resist
		DamageEnums.DamageType.Blunt:
			element_resist = defenses.blunt_resist
	
	# Formula:
	# (DMG * ((1 - ElementResist)(1 - TypeResist))) - Defense
	# get the taken percents of both element and type and multiply them
	# together to get the total taken damage
	var element_damage_taken_percent = 1.0 - element_resist
	var type_damage_taken_percent = 1.0 - type_resist
	var damage_taken_percent = element_damage_taken_percent * type_damage_taken_percent
	adjusted_damage_amount *= damage_taken_percent
	adjusted_damage_amount -= defenses.armor_defense
#	print_debug("adjusted damage amount before round: %f" % adjusted_damage_amount)
	adjusted_damage_amount = int(round(adjusted_damage_amount))
	
	# to ensure that the attack doesn't end up healing with a negative number
	adjusted_damage_amount = max(adjusted_damage_amount, 0)
	
	return adjusted_damage_amount


# equipment functions
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
	player_stats_changed.emit()


func adjust_defenses(item: Item, equipping: bool = true):
	var item_resource = item.item_resource as ArmorResource
	# if the item passed in is not an armor resource then return
	if !item_resource is ArmorResource:
		print_debug("item was not ArmorResource")
		return
	
	# else it is an item and can adjust the stats
	var equip_control = 1 if equipping else -1
	var string = "Equipping: " if equipping else "Unequipping: "
#	print_debug(string + item_resource.get_item_info())
	
	# manually add the stats from the item to the dictionary
	# using the equip_control as modifier for equipping/unequipping the stat changes
	defenses.armor_defense    += (equip_control * item_resource.armor_defense)
	defenses.physical_resist  += (equip_control * item_resource.physical_resist)
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
	
	# if any of the defenses end up at -0, change them to 0
	# this doesn't affect any calculations, only affects ui when stats are displayed
	if str(defenses.armor_defense)    == "-0": defenses.armor_defense = 0
	if str(defenses.physical_resist)  == "-0": defenses.physical_resist = 0
	if str(defenses.fire_resist)      == "-0": defenses.fire_resist = 0
	if str(defenses.water_resist)     == "-0": defenses.water_resist = 0
	if str(defenses.wind_resist)      == "-0": defenses.wind_resist = 0
	if str(defenses.earth_resist)     == "-0": defenses.earth_resist = 0
	if str(defenses.lightning_resist) == "-0": defenses.lightning_resist = 0
	if str(defenses.ice_resist)       == "-0": defenses.ice_resist = 0
	if str(defenses.light_resist)     == "-0": defenses.light_resist = 0
	if str(defenses.dark_resist)      == "-0": defenses.dark_resist = 0
	if str(defenses.slash_resist)     == "-0": defenses.slash_resist = 0
	if str(defenses.pierce_resist)    == "-0": defenses.pierce_resist = 0
	if str(defenses.blunt_resist)     == "-0": defenses.blunt_resist = 0
	
#	print_debug("Defenses: " + str(defenses))
	player_stats_changed.emit()


# set functions for all armors are pretty much the same except for which key it
# affects in equipment dictionary, just keeping them as
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
