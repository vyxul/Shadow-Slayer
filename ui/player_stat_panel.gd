extends PanelContainer

@onready var level_value_label = %LevelValueLabel
@onready var hp_value_label = %HPValueLabel
@onready var mp_value_label = %MPValueLabel
@onready var speed_value_label = %SpeedValueLabel
@onready var defense_value_label = %DefenseValueLabel
@onready var physical_resist_value_label = %PhysicalResistValueLabel
@onready var fire_resist_value_label = %FireResistValueLabel
@onready var water_resist_value_label = %WaterResistValueLabel
@onready var wind_resist_value_label = %WindResistValueLabel
@onready var earth_resist_value_label = %EarthResistValueLabel
@onready var lightning_resist_value_label = %LightningResistValueLabel
@onready var ice_resist_value_label = %IceResistValueLabel
@onready var light_resist_value_label = %LightResistValueLabel
@onready var dark_resist_value_label = %DarkResistValueLabel
@onready var slash_resist_value_label = %SlashResistValueLabel
@onready var pierce_resist_value_label = %PierceResistValueLabel
@onready var blunt_resist_value_label = %BluntResistValueLabel


func _ready():
	update_player_stat_panel()
	PlayerStats.player_stats_changed.connect(update_player_stat_panel)


func update_player_stat_panel():
	# stats
	level_value_label.text = str(PlayerStats.stats.level)
	hp_value_label.text = "%d / %d" % [PlayerStats.stats.current_hp, PlayerStats.stats.current_max_hp]
	mp_value_label.text = "%d / %d" % [PlayerStats.stats.current_mana, PlayerStats.stats.max_mana]
	speed_value_label.text = str(PlayerStats.stats.move_speed)
	
	# defenses
	defense_value_label.text = str(PlayerStats.defenses.armor_defense)
	physical_resist_value_label.text = str(PlayerStats.defenses.physical_resist)
	fire_resist_value_label.text = str(PlayerStats.defenses.fire_resist)
	water_resist_value_label.text = str(PlayerStats.defenses.water_resist)
	wind_resist_value_label.text = str(PlayerStats.defenses.wind_resist)
	earth_resist_value_label.text = str(PlayerStats.defenses.earth_resist)
	lightning_resist_value_label.text = str(PlayerStats.defenses.lightning_resist)
	ice_resist_value_label.text = str(PlayerStats.defenses.ice_resist)
	light_resist_value_label.text = str(PlayerStats.defenses.light_resist)
	dark_resist_value_label.text = str(PlayerStats.defenses.dark_resist)
	slash_resist_value_label.text = str(PlayerStats.defenses.slash_resist)
	pierce_resist_value_label.text = str(PlayerStats.defenses.pierce_resist)
	blunt_resist_value_label.text = str(PlayerStats.defenses.blunt_resist)


func set_panel_visible(state: bool):
	visible = state
