extends Node

var player_hp_change_flat: int = 10
var player_hp_multiplier: float = 2.0


func apply_effect():
	var player_hp_percent_amount = int(PlayerStats.stats.base_max_hp * (player_hp_multiplier - 1))
	var player_hp_change_amount = player_hp_percent_amount + player_hp_change_flat
	if player_hp_change_amount == 0:
		return
	
	PlayerStats.stats.current_max_hp += player_hp_change_amount
	
	# if change amount > 0, increase current hp as well
	if player_hp_change_amount > 0:
		PlayerStats.stats.current_hp += player_hp_change_amount
	# else if it was negative (< 0)
	else:
		# if current max hp < current hp, make current hp equal to it
		if PlayerStats.stats.current_max_hp < PlayerStats.stats.current_hp:
			PlayerStats.stats.current_hp = PlayerStats.stats.current_max_hp
	
	# let playerstats check to make sure that current hp is in range
	PlayerStats.check_hp()
	PlayerStats.emit_player_hp_changed()


func remove_effect():
	# not just setting current_max_hp to base_max_hp 
	# in case we allow multiple hp status effects at once
	var player_hp_remove_flat_change = PlayerStats.stats.current_max_hp - player_hp_change_flat
	var player_hp_original_max = player_hp_remove_flat_change / player_hp_multiplier
	
	PlayerStats.stats.current_max_hp = player_hp_original_max
	
	# let playerstats check to make sure that current hp is in range
	# check_hp will also emit signal that player stats changed
	PlayerStats.check_hp()
	PlayerStats.emit_player_hp_changed()
