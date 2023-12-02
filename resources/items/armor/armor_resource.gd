extends ItemResource
class_name ArmorResource

@export_group("Armor Meta-Data")
@export var armor_type: ItemTypeEnums.ArmorType

@export_group("Armor Stats")
@export var armor_defense: int
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
