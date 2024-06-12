extends TextureRect;
class_name ArenaSelect;

@export var select_box : SelectBox;

func focus() -> void:
	
	select_box.start_flash();

func unfocus() -> void:
	
	select_box.stop_flash();
	select_box.hide();
