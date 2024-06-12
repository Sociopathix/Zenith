extends Node;

@export var character_scene : PackedScene;
@export var start_label : Label;
@export var background : TextureRect;

@export_dir var images_dir : 	String;
@export var color_list : Array[Color];
@export var character_names : Array[String];

var character_list : Array[CharacterSelect];
var start_screen : bool = true;
var color_index : int = 0;
var character_index : int = 0;

func _ready() -> void:
	
	update_screen();

func _input(event : InputEvent) -> void:
	
	if start_screen:
		
		if event.is_action_pressed("ui_accept"):
			
			start_screen = false;
			update_screen();
		
		elif event.is_action_pressed("ui_cancel"):
			
			get_tree().quit();
	
	else:
		
		if event.is_action_pressed("ui_cancel"):
			
			start_screen = true;
			update_screen();
		
		elif event.is_action_pressed("ui_left"):
			
			switch_focus(-1);
		
		elif event.is_action_pressed("ui_right"):
			
			switch_focus(1);

func update_screen() -> void:
	
	if not character_list.is_empty():
		
		for c in character_list:
			
			c.queue_free();
		
		character_list.clear();
	
	if start_screen:
		
		start_label.show(); 
		background.texture = load(images_dir + "/startScreen.png");
	
	else:
		
		start_label.hide();
		background.texture = load(images_dir + "/selectScreen.png");
		for i in range(character_names.size()):
			
			var character_instance : CharacterSelect = character_scene.instantiate();
			character_instance.character_name = character_names[i];
			character_instance.texture = load(images_dir + "/fighter" + str(i) + ".png");
			character_instance.position = Vector2(18 + 134 * i, 252);
			character_list.append(character_instance);
			add_child(character_instance, true);
		
		character_index = 0;
		character_list[character_index].focus();

func switch_focus(direction : int) -> void:
	
	character_list[character_index].unfocus();
	character_index = (character_index + direction) % character_list.size();
	character_list[character_index].focus();

func _on_timer_timeout() -> void:
	
	#start_label.visible = ! start_label.visible;
	color_index = (color_index + 1) % color_list.size();
	start_label.add_theme_color_override("font_color", color_list[color_index]);
	start_label.add_theme_color_override("font_outline_color", color_list[color_index]);
