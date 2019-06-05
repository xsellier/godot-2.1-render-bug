extends PanelContainer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	var current_screen = OS.get_current_screen()

	# Fix the initialization for dual screen
	OS.set_window_fullscreen(true)
	OS.set_current_screen(current_screen)
