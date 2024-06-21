extends Node;

# CONSTANTS
enum SCREENS {START, CHARACTER, ARENA, FIGHT};

# SCENE REFERENCES
@export var selection_scene : PackedScene;

# NODE REFERENCES
@export var background : TextureRect;
@export var start_label : StartLabel;

# VARIABLES
# A list of the character names.
@export var character_names : Array[String];
# A list of Selection nodes representing the characters being shown on the screen.
var characters : Array[Selection];
# The position of the current character that has the focus.
var character_index : int = 0;
# Which screen we currently are on.
var screen : int = SCREENS.START; 

# Automatically called when the scene is loaded in.
func _ready() -> void:
	# Set to start screen.
	screen = SCREENS.START;
	_update_screen();

# Automatically called when detecting unhandled keyboard inputs.
func _unhandled_key_input(event : InputEvent) -> void:
	
	if screen == SCREENS.START: # Start Screen
		
		if event.is_action_pressed("ui_accept"): # Enter
			# Set to character select screen.
			screen = SCREENS.CHARACTER;
			_update_screen();
		
		elif event.is_action_pressed("ui_cancel"): # Escape
			# Closes the game.
			get_tree().quit(); 
	
	elif screen == SCREENS.CHARACTER: # Character Select Screen
		
		if event.is_action_pressed("ui_cancel"): # Escape
			# Set to start screen.
			screen = SCREENS.START;
			_update_screen();
		
		elif event.is_action_pressed("ui_accept"): # Enter
			
			screen = SCREENS.FIGHT;
			_update_screen();
		
		elif event.is_action_pressed("ui_left"): # Left Arrow
			# Switch focus to the left.
			_switch_focus(-1); 
		
		elif event.is_action_pressed("ui_right"): # Right Arrow
			# Switch focus to the right.
			_switch_focus(1); 

# Used to update when changing between screens.
func _update_screen() -> void:
	# For each node in the characters list.
	for c in characters:
		# Deletes the node from the Scene Tree.
		c.queue_free(); 
	# Empty the list so we don't have null references.
	characters.clear(); 
	
	if screen == SCREENS.START: # Start Screen
		
		background.texture = load("res://Assets/startScreen.png");
		start_label.show();
	
	elif screen == SCREENS.CHARACTER: # Character Select Screen
		
		background.texture = load("res://Assets/selectScreen.png");
		start_label.hide();
		
		# Spawn the Selection options from left to right.
		for i in range(7):
			
			var selection_instance = selection_scene.instantiate();
			selection_instance.name = character_names[i];
			selection_instance.texture = load("res://Assets/fighter" + str(i) + ".png");
			selection_instance.position = Vector2(18 + 134 * i, 252);
			characters.append(selection_instance);
			add_child(selection_instance, true);
		
		# Reset the focused Selection.
		character_index = 0;
		characters[character_index].focus();
	
	elif screen == SCREENS.FIGHT:
		
		background.texture = load("res://Assets/arena" + str(0) + "f.png");

# Used to switch focus between Selection nodes.
func _switch_focus(direction : int) -> void:
	# Unfocus the old Selection.
	characters[character_index].unfocus();
	# Update the index either to the left or right.
	character_index = (character_index + direction) % characters.size();
	# Focus the new Selection.
	characters[character_index].focus();
