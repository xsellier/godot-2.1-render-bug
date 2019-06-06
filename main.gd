extends PanelContainer

onready var current_message = get_node('VBoxContainer/Label')

onready var close_button = get_node('VBoxContainer/HBoxContainer/close')
onready var refresh_button = get_node('VBoxContainer/HBoxContainer/refresh')
onready var fullscreen_button = get_node('VBoxContainer/HBoxContainer/fullscreen')
onready var fullscreen_alt_button = get_node('VBoxContainer/HBoxContainer/fullscreenAlt')

var alternative_full_screen = false

func _ready():
  close_button.connect('pressed', self, 'close')
  refresh_button.connect('pressed', self, 'refresh')
  fullscreen_button.connect('pressed', self, 'toggle_fullscreen')
  fullscreen_alt_button.connect('pressed', self, 'toggle_fullscreen_alt')

  refresh()

func close():
  get_tree().quit()

func refresh():
  var current_screen = OS.get_current_screen()
  var screen_size = OS.get_screen_size(current_screen)
  var screen_position = OS.get_screen_position(current_screen)
  var screen_count = OS.get_screen_count()
  var video_mode_size = OS.get_video_mode_size(current_screen)

  var message = 'Current Screen (index): %s\nScreen size: %s\nScreen position: %s\nAmount of screen(s): %s\nVideo mode: %s' % [current_screen, screen_size, screen_position, screen_count, video_mode_size]

  current_message.set_text(message)

func _reset():
  OS.set_window_size(Vector2(1280, 720))
  OS.set_borderless_window(false)

  alternative_full_screen = false

func toggle_fullscreen():
  var is_fullscreen = OS.is_window_fullscreen()

  _reset()
  OS.set_window_fullscreen(not is_fullscreen)

func toggle_fullscreen_alt():
  OS.set_window_fullscreen(false)

  if alternative_full_screen:
    _reset()
  else:
    alternative_full_screen = true

    var current_screen = OS.get_current_screen()
    var screen_size = OS.get_screen_size(current_screen)
    var screen_position = OS.get_screen_position(current_screen)

    OS.set_borderless_window(true)
    OS.set_window_position(screen_position)

    # Force to high rez
    OS.set_window_size(Vector(2560, 1440))
