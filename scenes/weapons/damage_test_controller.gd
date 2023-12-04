extends Node

var test_item_resource: ItemResource = preload("res://resources/items/weapons/weapon_resources/test/test_weapon_resource.tres")
var test_weapon_scene = preload("res://scenes/weapons/damage_test_weapon.tscn")


func use_weapon():
	var test_weapon_instance = test_weapon_scene.instantiate()
	var player = get_tree().get_first_node_in_group("player")
	var node_location = player.get_sprite()
	node_location.add_child(test_weapon_instance)
	test_weapon_instance.attack(test_item_resource)


func _input(event: InputEvent):
	if event.is_action_pressed("attack_self"):
		use_weapon()
	
