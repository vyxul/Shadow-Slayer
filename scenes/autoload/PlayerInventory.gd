extends Node

@export var test_array: Array[Item] = []
@export var test_item: Item

var weapon_inventory:    Array[Item] = []
var armor_inventory:     Array[Item] = []
var accessory_inventory: Array[Item] = []
var ability_inventory:   Array[Item] = []


# used only for testing that inventory works as expected
func _ready():
	for item in test_array:
		add_item(item)
#	remove_item(test_item)


func get_weapon_inventory() -> Array[Item]:
	return weapon_inventory


func get_armor_inventory() -> Array[Item]:
	return armor_inventory


func get_accessory_inventory() -> Array[Item]:
	return accessory_inventory


func get_ability_inventory() -> Array[Item]:
	return ability_inventory


# will check which category the item belongs in and removes it
# from the corresponding inventory array
func remove_item(item: Item):
	var item_resource = item.item_resource
	var inventory_array = null
	# can do a match statement here later when we have more item types
#	print_debug("REMOVE: " + item_resource.get_item_info())
	if item_resource is WeaponResource:
#		print_debug("Classified as a weapon")
		inventory_array = weapon_inventory
		
	inventory_array.erase(item)
#	print_debug(inventory_array_to_string(inventory_array))


# will categorize the item into the 4 item_resource child types we have and
# add the item into the appropriate inventory array
func add_item(item: Item):
	var item_resource = item.item_resource as ItemResource
	var inventory_array = null
	# can do a match statement here later when we have more item types
#	print_debug("ADD: " + item_resource.get_item_info())
	if item_resource is WeaponResource:
#		print_debug("Classified as a weapon")
		inventory_array = weapon_inventory
	elif item_resource is ArmorResource:
#		print_debug("Classified as armor")
		inventory_array = armor_inventory
	elif item_resource is AccessoryResource:
#		print_debug("Classified as an accessory")
		inventory_array = accessory_inventory
	elif item_resource is AbilityResource:
#		print_debug("Classified as an ability")
		inventory_array = ability_inventory
	# else its not a recognized item, do not add
	else:
#		print_debug("Not any of our establised items")
		return
	
	inventory_array.append(item)
	sort_inventory(inventory_array)
#	print_debug(inventory_array_to_string(inventory_array))


# helper function to call custom sort method for a variable array
func sort_inventory(inventory_array: Array[Item]):
	inventory_array.sort_custom(sort_ascending)


# sorts the item based on the item_resource.item_id
func sort_ascending(a: Item, b: Item):
	var a_id = a.item_resource.item_id
	var b_id = b.item_resource.item_id
	return a_id < b_id


# custom to_string method for the inventory arrays
# does not list the name of the array
func inventory_array_to_string(inventory_array: Array[Item]) -> String:
	var return_string = "[ "
	
	for item in inventory_array:
		var item_resource = item.item_resource
		var item_string = "("
		item_string = item_string + str(item_resource.item_id) + ", " \
					  + item_resource.item_name + ")"
		return_string += item_string
	
	return return_string + " ]"


# implement later when we have save system
func save_inventory():
	pass


func load_inventory():
	pass
