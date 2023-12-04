extends Area2D
class_name PlayerHurtboxComponent

var floating_text_scene = preload("res://ui/floating_text.tscn")

func damage(damage_stats: Dictionary):
	var damage_amount = PlayerStats.damage(damage_stats)
	
	# set up the floating text scene
	var floating_text_instance = floating_text_scene.instantiate() as Node2D
	get_tree().get_first_node_in_group("foreground_layer").add_child(floating_text_instance)
	floating_text_instance.global_position = global_position + (Vector2.UP * 16)
	floating_text_instance.set_color(Color.DARK_RED)
	# get the damage formatted into string
	var format_string = "%d"
	floating_text_instance.start(format_string % damage_amount)


# only temporary to have heal and damage in same spot for now
# also for the floating text code
func _input(event: InputEvent):
	if event.is_action_pressed("heal"):
		var heal_amount = 1
		PlayerStats.heal(heal_amount)
		
		# set up the floating text scene
		var floating_text_instance = floating_text_scene.instantiate() as Node2D
		get_tree().get_first_node_in_group("foreground_layer").add_child(floating_text_instance)
		floating_text_instance.global_position = global_position + (Vector2.UP * 16)
		floating_text_instance.set_color(Color.GREEN)
		# get the damage formatted into string
		var format_string = "%d"
		floating_text_instance.start(format_string % heal_amount)
