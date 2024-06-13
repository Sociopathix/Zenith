extends TextureRect;
class_name Selection;

@export var select_box : SelectBox;

var character_name : String;

func _ready() -> void:
	
	set_material(get_material().duplicate());

func focus() -> void:
	
	select_box.start_flashing();
	get_material().set_shader_parameter("grayscale", false);

func unfocus() -> void:
	
	select_box.stop_flashing();
	select_box.hide();
	get_material().set_shader_parameter("grayscale", true);
