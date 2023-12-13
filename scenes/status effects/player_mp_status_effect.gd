extends Node

var player_mp_change_flat: int = 10
var player_mp_multiplier: float = 2.0


func apply_effect():
	var player_mp_percent_amount = int(PlayerStats.stats.base_max_mana * (player_mp_multiplier - 1))
	var player_mp_change_amount = player_mp_percent_amount + player_mp_change_flat
	if player_mp_change_amount == 0:
		return
	
	PlayerStats.stats.current_max_mana += player_mp_change_amount
	
	# if change amount > 0, increase current mana as well
	if player_mp_change_amount > 0:
		PlayerStats.stats.current_mana += player_mp_change_amount
	# else if it was negative (< 0)
	else:
		# if current max mp < current mp, make current mp equal to it
		if PlayerStats.stats.current_max_mana < PlayerStats.stats.current_mana:
			PlayerStats.stats.current_mana = PlayerStats.stats.current_max_mana
	
	# let playerstats check to make sure that current mp is in range
	# check_mana will also emit signal that player stats changed
	PlayerStats.check_mana()
	PlayerStats.emit_player_mana_changed()


func remove_effect():
	# not just setting current_max_hp to base_max_hp 
	# in case we allow multiple hp status effects at once
	var player_mp_remove_flat_change = PlayerStats.stats.current_max_mana - player_mp_change_flat
	var player_mp_original_max = player_mp_remove_flat_change / player_mp_multiplier
	
	PlayerStats.stats.current_max_mana = player_mp_original_max
	
	# let playerstats check to make sure that current mp is in range
	# check_mana will also emit signal that player stats changed
	PlayerStats.check_mana()
	PlayerStats.emit_player_mana_changed()
