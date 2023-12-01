extends Node
class_name HealthComponent

signal died
signal hp_lost(damage_taken: int, new_current_hp: int, max_hp: int)
signal hp_healed(health_healed: int, new_current_hp: int, max_hp: int)

@export var max_hp: int = 1
var current_hp: int

@export_group("ArmorComponent Set Up")
@export var armor_component: ArmorComponent

func _ready():
	current_hp = max_hp


func check_hp():
	# if hp at 0, send died signal for parent entity to queue free
	if current_hp <= 0:
		died.emit()
		
	# clamp the current hp within bounds of 0 <--> max hp
	current_hp = clamp(current_hp, 0, max_hp)


func damage(damage_stats: Dictionary) -> int:
	var damage_amount  = damage_stats["damage"]
	var damage_element = damage_stats["damage_element"]
	var damage_type    = damage_stats["damage_type"]
	
#	print_debug("current hp = %d, damage = %d, damage_element = %d, damage_type = %d" \
#			   % [current_hp, damage_amount, damage_element, damage_type])
	
	var adjusted_damage_amount = damage_amount
	# if entity has an armor component, use an adjusted damage amount, 
	# otherwise use the raw damage amount
	if armor_component:
		adjusted_damage_amount = armor_component.adjust_damage(damage_stats)
#		print_debug("adjusted damage: %d" % adjusted_damage_amount)
	
	current_hp -= adjusted_damage_amount
	check_hp()
	hp_lost.emit(adjusted_damage_amount, current_hp, max_hp)
	
	return adjusted_damage_amount


func heal(heal_amount: int):
	current_hp += heal_amount
	check_hp()
	hp_healed.emit(heal_amount, current_hp, max_hp)
