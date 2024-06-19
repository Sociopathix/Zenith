extends Node;

# Scenes
@export var selection_scene : PackedScene;

# Node References
@export var background : TextureRect;
@export var start_label : StartLabel;

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
		
		elif event.is_action_pressed("ui_cancel"):
			
			get_tree().quit();
	
	else:
		
		if event.is_action_pressed("ui_cancel"):
			
			start_screen = true;
			_update_screen();

func _update_screen() -> void:
	
	if start_screen:
		
		background.texture = load("res://Assets/startScreen.png");
		start_label.show();
	
	else:
		
		background.texture = load("res://Assets/selectScreen.png");
		start_label.hide();
		
		for i in range(7):
			
			var selection_instance = selection_scene.instantiate();
			selection_instance.texture = load("res://Assets/fighter" + str(i) + ".png");
			selection_instance.position = Vector2(18 + 134 * i, 252);
			add_child(selection_instance, true);
