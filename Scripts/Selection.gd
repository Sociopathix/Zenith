extends TextureRect;
class_name Selection;

@export var select_box : TextureRect;

func _ready() -> void:
	
	set_material(get_material().duplicate());

func focus() -> void:
	
	get_material().set_shader_parameter("grayscale", false);
	select_box.show();

func unfocus() -> void:
	
	get_material().set_shader_parameter("grayscale", true);
	select_box.hide();
