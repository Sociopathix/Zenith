extends Node;

@export_group("General")
@export var background : TextureRect;
@export_dir var images_dir : 	String;

@export_group("Start Screen")
@export var start_label : Label;
@export var color_list : Array[Color];
var color_index : int = 0;

@export var selection_scene : PackedScene;

@export_group("Character Screen")
@export var character_label : Label;
@export var character_names : Array[String];
var character_list : Array[Selection];
var character_index : int = 0;
var character_chosen : bool = false;

@export_group("Arena Screen")
var arena_list : Array[Selection];
var arena_index : int = 0;
var arena_chosen : bool = false;

enum SCREENS {START, CHARACTER, ARENA, GAME};
var screen : int = SCREENS.START;

# Called automatically whenever the game first loads.
func _ready() -> void:
	
	update_screen();

# Called automatically whenever any input is made (eg. clicking, mouse movement, key presses, etc).
func _input(event : InputEvent) -> void:

	# If currently on the start screen.
	if screen == SCREENS.START:

		# If you press enter on the start screen, change to the character select screen.
		if event.is_action_pressed("ui_accept"):
			
			screen = SCREENS.CHARACTER;
			update_screen();

		# If you press escape on the start screen, close the program.
		elif event.is_action_pressed("ui_cancel"):
			
			get_tree().quit();

	# If currently on the character select screen.
	elif screen == SCREENS.CHARACTER:

		# If you press the escape button on the character select screen:
			# If you have not chosen a character, change back to the start screen.
			# If you have chosen a character, deselect the character and restart the flashing animation.
		if event.is_action_pressed("ui_cancel"):
			
			if not character_chosen:
				
				screen = SCREENS.START;
				update_screen();
			
			else:
				
				character_chosen = false;
				character_list[character_index].select_box.start_flashing();

		# If you press the enter button on the character select screen:
			# If you have not chosen a character, select the current character and stop the flashing animation.
			# if you have chosen a character, change to arena select screen.
		elif event.is_action_pressed("ui_accept"):
			
			if not character_chosen:
				
				character_chosen = true;
				character_list[character_index].select_box.stop_flashing();
			
			else:
				
				screen = SCREENS.ARENA;
				update_screen();

		# If you press the left arrow and haven't chosen a character, switch the focus to the character to the left.
		elif event.is_action_pressed("ui_left") and not character_chosen:
			
			switch_focus(-1);

		# If you press the right arrow and haven't chosen a character, switch the focus to the character to right.
		elif event.is_action_pressed("ui_right") and not character_chosen:
			
			switch_focus(1);

	# If currently on the arena select screen.
	elif screen == SCREENS.ARENA:

		# If you press the escape button on the arena select screen:
			# If you have not chosen an arena, change back to the character select screen.
			# If you have chosen an arena, deselect the arena and restart the flashing animation.
		if event.is_action_pressed("ui_cancel"):
			
			if not arena_chosen:
				
				screen = SCREENS.CHARACTER;
				update_screen();
			
			else:
				
				arena_chosen = false;
				arena_list[arena_index].select_box.start_flashing();

		# If you press the enter button on the arena select screen:
			# If you have not chosen an arena, select the current arena and stop the flashing animation.
			# If you have chosen an arena, change to the game screen.
		elif event.is_action_pressed("ui_accept"):
			
			if not arena_chosen:
				
				arena_chosen = true;
				arena_list[arena_index].select_box.stop_flashing();
			
			else:
				
				screen = SCREENS.GAME;
				update_screen();

		# If you press the left arrow and haven't chosen an arena, switch the focus to the arena to the left.
		elif event.is_action_pressed("ui_left") and not arena_chosen:
			
			switch_focus(-1);
		# If you press the right arrow and haven't chosen an arena, switch the focus to the arena to the right.
		elif event.is_action_pressed("ui_right") and not arena_chosen:
			
			switch_focus(1);

# Called whenever we call this function, which we do whenever we change screens. Updates the UI for each screen.
func update_screen() -> void:

	# If the character list is not empty whenever we change screens, delete them from the scene and clear the list.
	if not character_list.is_empty():
		
		for c in character_list:
			
			c.queue_free();
		
		character_list.clear();
	# If the arena list is not empty whenever we change screens, delete them from the scene and clear the list.
	if not arena_list.is_empty():
		
		for a in arena_list:
			
			a.queue_free();
		
		arena_list.clear();

	# If the screen we want to display is the start screen:
		# Hide any elements from the character select screen.
		# Show the "PRESS ENTER" label.
		# Change the background to the start screen image.
	if screen == SCREENS.START:
		
		character_label.hide();
		start_label.show(); 
		
		background.texture = load(images_dir + "/startScreen.png");

	# If the screen we want to display is the character select screen:
		# Hide any elements from the start screen.
		# Show the character name label.
		# Change the background to the character select screen image.
		# For each character, create a character icon and add them to the character list and to the scene.
		# If a character is not chosen, start with the focus on the first icon.
		# If a character has previously been chosen, focus that character icon and stop the flashing animation.
		# Update the player name label with the name of the current character.
	elif screen == SCREENS.CHARACTER:
		
		start_label.hide();
		character_label.show();
		
		background.texture = load(images_dir + "/selectScreen.png");
		for i in range(character_names.size()):
			
			var character_instance : Selection = selection_scene.instantiate();
			character_instance.character_name = character_names[i];
			character_instance.texture = load(images_dir + "/fighter" + str(i) + ".png");
			character_instance.position = Vector2(18 + 134 * i, 252);
			character_list.append(character_instance);
			add_child(character_instance, true);
		
		if not character_chosen:
			
			character_index = 0;
			character_list[character_index].focus();
		
		else:
			
			character_list[character_index].focus() # GO OVER TOMORROW
			character_list[character_index].select_box.stop_flashing();
		
		character_label.text = "P1: " + character_list[character_index].character_name;

	# If the screen we want to display is the arena select screen:
		# Hide any elements from the character select screen.
		# Change the background to the arena select screen image.
		# For each arena, create a arena icon and add them to the arena list and to the scene.
		# If an arena is not chosen, start with the focus on the first icon.
		# If an arena has previously been chosen, focus that arena icon and stop the flashing animation.
	elif screen == SCREENS.ARENA:
		
		character_label.hide();
		
		background.texture = load(images_dir + "/arenaScreen.png");
		for i in range(4):
			
			var arena_instance : Selection = selection_scene.instantiate(); # : CharacterSelect = character_scene.instantiate;
			arena_instance.texture = load(images_dir + "/arena" + str(i) + ".png");
			arena_instance.select_box.texture = load(images_dir + "/arenaselect.png"); # NEW
			arena_instance.position = Vector2(38 + 232 * i, 252);
			arena_instance.set_material(arena_instance.get_material().duplicate()); # NEW
			arena_instance.get_material().set_shader_parameter("grayscale", false); # NEW
			arena_list.append(arena_instance);
			add_child(arena_instance, true);
		
		if not arena_chosen:
			
			arena_index = 0;
			arena_list[arena_index].focus()

	# If the screen we want to display is the game screen:
		# Change the background to the full version of the selected arena map image.
	elif screen == SCREENS.GAME:
		
		background.texture = load(images_dir + "/arena" + str(arena_index) + "f.png");

# We call this whenever we want to switch the selection focus on either of the select screens.
func switch_focus(direction : int) -> void:
	
	if screen == SCREENS.CHARACTER:
		
		character_list[character_index].unfocus();
		character_index = (character_index + direction) % character_list.size();
		character_list[character_index].focus();

		# Update the character name label.
		character_label.text = "P1: " + character_list[character_index].character_name;
	
	elif screen == SCREENS.ARENA:
		
		arena_list[arena_index].unfocus();

		# Override the grayscale shader so the arena icons don't turn gray.
		arena_list[arena_index].get_material().set_shader_parameter("grayscale", false);

		arena_index = (arena_index + direction) % arena_list.size();
		arena_list[arena_index].focus();

# Called automatically whenever the "PRESS ENTER" label timer times out.
func _on_timer_timeout() -> void:
	
	#start_label.visible = ! start_label.visible; # OLD CODE.

	# Alternate the color index.
	color_index = (color_index + 1) % color_list.size();

	# Update the font colors to the new color (green or black).
	start_label.add_theme_color_override("font_color", color_list[color_index]);
	start_label.add_theme_color_override("font_outline_color", color_list[color_index]);
