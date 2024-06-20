extends Node;

# Scenes
@export var selection_scene : PackedScene;

# Node References
@export var background : TextureRect;
@export var start_label : StartLabel;

# Variables
@export var character_names : Array[String];
var characters : Array[Selection];
var start_screen : bool;
var character_index : int = 0;

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
	
	else: # Character Select Screen
		
		if event.is_action_pressed("ui_cancel"): # Escape
			
			start_screen = true;
			_update_screen();
		
		elif event.is_action_pressed("ui_left"): # Left Arrow
			
			_switch_focus(-1);
		
		elif event.is_action_pressed("ui_right"): # Right Arrow
			
			_switch_focus(1);

func _update_screen() -> void:
	
	for c in characters:
		
		c.queue_free();
	
	characters.clear();
	
	if start_screen:
		
		background.texture = load("res://Assets/startScreen.png");
		start_label.show();
	
	else:
		
		background.texture = load("res://Assets/selectScreen.png");
		start_label.hide();
		
		for i in range(7):
			
			var selection_instance = selection_scene.instantiate();
			selection_instance.name = character_names[i];
			selection_instance.texture = load("res://Assets/fighter" + str(i) + ".png");
			selection_instance.position = Vector2(18 + 134 * i, 252);
			characters.append(selection_instance);
			add_child(selection_instance, true);
		
		character_index = 0;
		characters[character_index].focus();

func _switch_focus(direction : int) -> void:
	
	characters[character_index].unfocus();
	character_index = (character_index + direction) % characters.size();
	characters[character_index].focus();
