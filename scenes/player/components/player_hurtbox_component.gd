extends Area2D
class_name PlayerHurtboxComponent

var floating_text_scene = preload("res://ui/floating_text.tscn")

func damage(damage_stats: Dictionary):
	var damage_amount = PlayerStats.damage(damage_stats)
