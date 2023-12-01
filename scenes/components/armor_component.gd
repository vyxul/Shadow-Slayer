extends Node
class_name ArmorComponent

## Flat defense value taken off the damage amount after resistances
@export var defense: int = 0

# Percent of the damage reduced or added to the original damage amount
@export_group("Damage Element Resistances")
@export_range(-1, 1) var physical_resist: float = 0
@export_range(-1, 1) var fire_resist: float = 0
@export_range(-1, 1) var water_resist: float = 0
@export_range(-1, 1) var wind_resist: float = 0
@export_range(-1, 1) var earth_resist: float = 0
@export_range(-1, 1) var lightning_resist: float = 0
@export_range(-1, 1) var ice_resist: float = 0
@export_range(-1, 1) var light_resist: float = 0
@export_range(-1, 1) var dark_resist: float = 0
@export_group("Damage Type Resistances")
@export_range(-1, 1) var slash_resist: float = 0
@export_range(-1, 1) var pierce_resist: float = 0
@export_range(-1, 1) var blunt_resist: float = 0

# returns the adjusted damage amount to the entity
func adjust_damage(damage_stats: Dictionary) -> int:
	var damage_amount  = damage_stats["damage"]
	var damage_element = damage_stats["damage_element"]
	var damage_type    = damage_stats["damage_type"]
	
	var adjusted_damage_amount = float(damage_amount)
	
	# get the elemental resistance of the armor for the incoming damage
	var element_resist = 0.0
	match(damage_element):
		DamageEnums.DamageElement.Physical:
			element_resist = physical_resist
		DamageEnums.DamageElement.Fire:
			element_resist = fire_resist
		DamageEnums.DamageElement.Water:
			element_resist = water_resist
		DamageEnums.DamageElement.Wind:
			element_resist = wind_resist
		DamageEnums.DamageElement.Earth:
			element_resist = earth_resist
		DamageEnums.DamageElement.Lightning:
			element_resist = lightning_resist
		DamageEnums.DamageElement.Ice:
			element_resist = ice_resist
		DamageEnums.DamageElement.Light:
			element_resist = light_resist
		DamageEnums.DamageElement.Dark:
			element_resist = dark_resist
			
	# get the type resistance of the armor for the incoming damage
	var type_resist = 0.0
	match(damage_type):
		DamageEnums.DamageType.Slash:
			element_resist = slash_resist
		DamageEnums.DamageType.Pierce:
			element_resist = pierce_resist
		DamageEnums.DamageType.Blunt:
			element_resist = blunt_resist
	
	# Formula:
	# (DMG * ((1 - ElementResist)(1 - TypeResist))) - Defense
	# get the taken percents of both element and type and multiply them
	# together to get the total taken damage
	var element_damage_taken_percent = 1.0 - element_resist
	var type_damage_taken_percent = 1.0 - type_resist
	var damage_taken_percent = element_damage_taken_percent * type_damage_taken_percent
	adjusted_damage_amount *= damage_taken_percent
	adjusted_damage_amount -= defense
#	print_debug("adjusted damage amount before round: %f" % adjusted_damage_amount)
	adjusted_damage_amount = int(round(adjusted_damage_amount))
	
	# to ensure that the attack doesn't end up healing with a negative number
	adjusted_damage_amount = max(adjusted_damage_amount, 0)
	
	return adjusted_damage_amount
