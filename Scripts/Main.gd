extends Node;

@export var start_label : Label;
@export var background : TextureRect;

@export_dir var images_dir : 	String;
@export var color_list : Array[Color];

var start_screen : bool = true;
var color_index : int = 0;

func _ready() -> void:
	
	update_screen();

func _input(event : InputEvent) -> void:
	
	if start_screen and event.is_action_pressed("ui_accept"):
		
		start_screen = false;
		update_screen();
	
	if not start_screen and event.is_action_pressed("ui_cancel"):
		
		start_screen = true;
		update_screen();

func update_screen() -> void:
	
	if start_screen:
		
		start_label.visible = true; 
		background.texture = load(images_dir + "/startScreen.png");
	
	else:
		
		start_label.visible = false;
		background.texture = load(images_dir + "/selectScreen.png");

func _on_timer_timeout() -> void:
	
	#start_label.visible = ! start_label.visible;
	color_index = (color_index + 1) % color_list.size();
	start_label.add_theme_color_override("font_color", color_list[color_index]);
	start_label.add_theme_color_override("font_outline_color", color_list[color_index]);
