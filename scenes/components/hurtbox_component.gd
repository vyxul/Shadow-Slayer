extends Area2D
class_name HurtboxComponent

@export var health_component: HealthComponent

var floating_text_scene = preload("res://ui/floating_text.tscn")

func _ready():
	if !health_component:
		print_debug("no health_component connected")


func damage(damage_stats: Dictionary):
	var damage_amount = health_component.damage(damage_stats)
	
	# set up the floating text scene
	var floating_text_instance = floating_text_scene.instantiate() as Node2D
	get_tree().get_first_node_in_group("foreground_layer").add_child(floating_text_instance)
	floating_text_instance.global_position = global_position + (Vector2.UP * 16)
	floating_text_instance.set_color(Color.RED)
	
	# get the damage formatted into string
	var format_string = "%d"
	floating_text_instance.start(format_string % damage_amount)

func heal(heal_amount: int):
	health_component.heal(heal_amount)
