extends Label;
class_name StartLabel;

@export var color_list : Array[Color];
var color_index : int = 0;

func _on_timer_timeout() -> void:
	
	#start_label.visible = ! start_label.visible;
	color_index = (color_index + 1) % color_list.size();
	add_theme_color_override("font_color", color_list[color_index]);
	add_theme_color_override("font_outline_color", color_list[color_index]);
