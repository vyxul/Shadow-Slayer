extends PanelContainer


func _on_gui_input(event: InputEvent):
	if event.is_action_pressed("left_click"):
		print_debug("mouse click detected on weapon inventory panel")


func set_panel_visible(state: bool):
	visible = state
