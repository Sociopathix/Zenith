extends TextureRect;
class_name CharacterSelect;

@export var select_box : SelectBox;

var character_name : String;

func focus() -> void:
	
	select_box.start_flash();

func unfocus() -> void:
	
	select_box.stop_flash();
	select_box.hide();
