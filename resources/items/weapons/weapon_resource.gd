extends ItemResource
class_name WeaponResource

@export_group("Weapon Meta-Data")
@export var weapon_type: ItemTypeEnums.WeaponType

@export_group("Weapon Stats")
@export var weapon_damage: int
@export var weapon_damage_element: DamageEnums.DamageElement = DamageEnums.DamageElement.PHYSICAL
@export var weapon_damage_type: DamageEnums.DamageType = DamageEnums.DamageType.SLASH
@export var weapon_cooldown_time: float
@export_range(0.01, 10) var weapon_size: float = 1.0
@export var weapon_pierce: int = 1

@export_group("Ranged Weapon Stats")
@export var weapon_magazine_size: int = 0
@export var weapon_magazine_reload_speed: float = 0
@export var weapon_projectile_speed: float = 0
