extends Label;
class_name StartLabel;

# VARIABLES
# Array with our green and black colors to switch between.
@export var color_list : Array[Color];
# Represents the current color of the label (0 : green, 1 : black).
var color_index : int = 0;

# Automatically called whenever the StartTimer times out.
func _on_start_timer_timeout() -> void:
	# Switch to the next color.
	color_index = (color_index + 1) % color_list.size();
	# Update the font colors to the new color.
	add_theme_color_override("font_color", color_list[color_index]);
	add_theme_color_override("font_outline_color", color_list[color_index]);
