extends Area2D
class_name HitboxComponent


func _on_area_entered(area: Area2D):
	# eventually make two different code blocks, one for when it hits standard
	# hurtbox, which will be for enemies
	# and one for when it hits specialized player hurtbox, which is only for player
#	print_debug(area.name)
	if not area is HurtboxComponent:
		return
	
	# get the damage stats from the parent node
	# must return as a dictionary with keys of: damage, damage_element, damage_type
	var damage_stats = get_parent().get_damage_stats()
	area.damage(damage_stats)
