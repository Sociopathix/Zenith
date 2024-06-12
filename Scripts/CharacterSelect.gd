extends TextureRect;
class_name CharacterSelect;

@export var select_box : TextureRect;

var character_name : String;

func focus() -> void:
	
	select_box.show();

func unfocus() -> void:
	
	select_box.hide();
