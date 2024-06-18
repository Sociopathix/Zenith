extends Node;

# Node References
@export var background : TextureRect;

# Variables
var start_screen : bool;

# Automatically called when the scene is loaded in.
func _ready() -> void:
	
	start_screen = true;
	_update_screen();

# Automatically called when detecting unhandled keyboard inputs.
func _unhandled_key_input(event : InputEvent) -> void:
	
	if start_screen:
		
		if event.is_action_pressed("ui_accept"):
			
			start_screen = false;
			_update_screen();

func _update_screen() -> void:
	
	if start_screen:
		
		background.texture = load("res://Assets/startScreen.png");
	
	else:
		
		background.texture = load("res://Assets/selectScreen.png");

