extends Area2D
class_name PlayerHurtboxComponent

var floating_text_scene = preload("res://ui/floating_text.tscn")

func damage(damage_stats: Dictionary):
	var damage_amount = PlayerStats.damage(damage_stats)
	
	# set up the floating text scene
	var floating_text_instance = floating_text_scene.instantiate() as Node2D
	get_tree().get_first_node_in_group("foreground_layer").add_child(floating_text_instance)
	floating_text_instance.global_position = global_position + (Vector2.UP * 16)
	floating_text_instance.set_color(Color.GREEN)
	# get the damage formatted into string
	var format_string = "%d"
	floating_text_instance.start(format_string % damage_amount)
