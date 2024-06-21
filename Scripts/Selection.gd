extends TextureRect;
class_name Selection;

# NODE REFERENCES
@export var select_box : TextureRect;

# Automatically called when the scene is loaded in.
func _ready() -> void:
	# Duplicates the material so each Selection has a unique material.
	set_material(get_material().duplicate());

# Used to set the focus to this node.
func focus() -> void:
	# Make it turn to color.
	get_material().set_shader_parameter("grayscale", false);
	select_box.start_flash();

# Used to remove the focus from this node.
func unfocus() -> void:
	# Make it turn to grayscale.
	get_material().set_shader_parameter("grayscale", true);
	select_box.stop_flash();
	
