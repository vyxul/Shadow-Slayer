extends CanvasLayer

@onready var equipment_panel = $EquipmentPanel
@onready var weapon_inventory_panel = $WeaponInventoryPanel

var showing_panels: bool = false

func _input(event: InputEvent):
	if event.is_action_pressed("inventory"):
		showing_panels = !showing_panels
		visible = showing_panels
		equipment_panel.set_panel_visible(showing_panels)
		weapon_inventory_panel.set_panel_visible(showing_panels)
