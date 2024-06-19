extends Label;
class_name StartLabel;

@export var color_list : Array[Color];

var color_index : int = 0;

func _on_start_timer_timeout() -> void:
	
	color_index = (color_index + 1) % color_list.size();
	add_theme_color_override("font_color", color_list[color_index]);
	add_theme_color_override("font_outline_color", color_list[color_index]);
