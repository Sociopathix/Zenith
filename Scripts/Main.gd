extends Node;

@export var character_scene : PackedScene;
@export var arena_scene : PackedScene # NEW
@export var background : TextureRect;
@export var start_label : Label;
@export var character_label : Label; # NEW
@export var arena_display : TextureRect; # NEW

@export_dir var images_dir : String;
@export var character_names : Array[String];
@export var arena_names : Array[String];

enum SCREENS {START, CHARACTER, ARENA, GAME};
var screen : int = SCREENS.START;

var character_list : Array[CharacterSelect];
var character_index : int = 0;
var character_chosen : bool = false;

var arena_list : Array[ArenaSelect];
var arena_index : int = 0;
var arena_chosen : bool = false;

func _ready() -> void:
	
	update_screen();

func _input(event : InputEvent) -> void:
	
	if screen == SCREENS.START:
		
		if event.is_action_pressed("ui_accept"):
			
			screen = SCREENS.CHARACTER;
			update_screen();
		
		elif event.is_action_pressed("ui_cancel"):
			
			get_tree().quit();
	
	elif screen == SCREENS.CHARACTER:
		
		if event.is_action_pressed("ui_cancel"):
			
			if not character_chosen:
				
				screen = SCREENS.START;
				update_screen();
			
			else:
				
				character_chosen = false;
				character_list[character_index].select_box.start_flash();
		
		elif event.is_action_pressed("ui_accept"):
			
			if not character_chosen:
				
				character_chosen = true;
				character_list[character_index].select_box.stop_flash();
			
			else:
				
				screen = SCREENS.ARENA;
				update_screen();
		
		elif event.is_action_pressed("ui_left") and not character_chosen:
			
			switch_focus(-1);
		
		elif event.is_action_pressed("ui_right") and not character_chosen:
			
			switch_focus(1);
	
	elif screen == SCREENS.ARENA:
		
		if event.is_action_pressed("ui_cancel"):
			
			if not arena_chosen:
				
				screen = SCREENS.CHARACTER;
				update_screen();
			
			else:
				
				arena_chosen = false;
				arena_list[arena_index].select_box.start_flash();
		
		if event.is_action_pressed("ui_accept"):
			
			if not arena_chosen:
				
				arena_chosen = true;
				arena_list[arena_index].select_box.stop_flash();
			
			else:
				
				screen = SCREENS.GAME;
				update_screen();
		
		elif event.is_action_pressed("ui_left") and not arena_chosen:
			
			switch_focus(-1);
		
		elif event.is_action_pressed("ui_right") and not arena_chosen:
			
			switch_focus(1);
	
	elif screen == SCREENS.GAME:
		
		if event.is_action_pressed("ui_cancel"):
			
			screen = SCREENS.ARENA;
			update_screen();

func update_screen() -> void:
	
	if not character_list.is_empty():
		
		for c in character_list:
			
			c.queue_free();
		
		character_list.clear();
	
	if not arena_list.is_empty():
		
		for a in arena_list:
			
			a.queue_free();
		
		arena_list.clear();
	
	if screen == SCREENS.START:
		
		character_label.hide();
		start_label.show(); 
		
		background.texture = load(images_dir + "/startScreen.png");
	
	elif screen == SCREENS.CHARACTER:
		
		start_label.hide();
		arena_display.hide();
		character_label.show();
		
		background.texture = load(images_dir + "/selectScreen.png");
		for i in range(character_names.size()):
			
			var character_instance : CharacterSelect = character_scene.instantiate();
			character_instance.character_name = character_names[i];
			character_instance.texture = load(images_dir + "/fighter" + str(i) + ".png");
			character_instance.position = Vector2(18 + 134 * i, 252);
			character_list.append(character_instance);
			add_child(character_instance, true);
		
		character_label.text = "P1: " + character_list[character_index].character_name;
		if not character_chosen:
			
			character_index = 0;
			character_list[character_index].focus();
		
		else:
			
			character_list[character_index].select_box.stop_flash();
	
	elif screen == SCREENS.ARENA:
		
		character_label.hide();
		
		background.texture = load(images_dir + "/arenaScreen.png");
		
		for i in range(arena_names.size()):
			
			var arena_instance : ArenaSelect = arena_scene.instantiate();
			arena_instance.texture = load(images_dir + "/" + arena_names[i] + ".png");
			arena_instance.position = Vector2(38 + 232 * i, 252);
			arena_list.append(arena_instance);
			add_child(arena_instance, true);
		
		if not arena_chosen:
			
			arena_index = 0;
			arena_list[arena_index].focus();
		
		else:
			
			arena_list[arena_index].select_box.stop_flash();
		
		arena_display.show();
		arena_display.texture = load(images_dir + "/" + arena_names[arena_index] + ".png");
	
	elif screen == SCREENS.GAME:
		
		arena_display.hide();
		background.texture = load(images_dir + "/" + arena_names[arena_index] + "f.png");

func switch_focus(direction : int) -> void:
	
	if screen == SCREENS.CHARACTER:
		
		character_list[character_index].unfocus();
		character_index = (character_index + direction) % character_list.size();
		character_list[character_index].focus();
		character_label.text = "P1: " + character_list[character_index].character_name;
	
	elif screen == SCREENS.ARENA:
		
		arena_list[arena_index].unfocus();
		arena_index = (arena_index + direction) % arena_list.size();
		arena_list[arena_index].focus();
		arena_display.texture = load(images_dir + "/" + arena_names[arena_index] + ".png");


