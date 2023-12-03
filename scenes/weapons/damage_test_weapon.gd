extends Node2D

var current_weapon_resource: WeaponResource


func set_attack_position():
	# Getting weapon position and angle relative to the player
	var player = get_tree().get_first_node_in_group("player")
	var player_position = player.global_position as Vector2
	global_position = player_position


func attack(weapon_resource: WeaponResource):
	current_weapon_resource = weapon_resource
	
	# set the weapon size and hitbox according to the weapon_size property of the weapon resource
	scale *= current_weapon_resource.weapon_size
	
	# get where the attack needs to spawn
	set_attack_position()
	
	# Getting weapon animation and setting the speed
	var animation = $AnimationPlayer.get_animation("attack")
	var animation_length = animation.length
	var cooldown_time = current_weapon_resource.weapon_cooldown_time
	var playback_speed = 1
	if cooldown_time < animation_length:
		playback_speed = animation_length / cooldown_time
		
	$AnimationPlayer.play("attack", -1, playback_speed)


func get_damage_stats() -> Dictionary:
	var damage_stats = {
		"damage": current_weapon_resource.weapon_damage,
		"damage_element": current_weapon_resource.weapon_damage_element,
		"damage_type": current_weapon_resource.weapon_damage_type
	}
	return damage_stats
