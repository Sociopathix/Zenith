extends TextureRect;
class_name SelectBox;

@export var select_timer : Timer;

func start_flash() -> void:
	
	select_timer.start();
	show();

func stop_flash() -> void:
	
	select_timer.stop();
	hide();

func _on_select_timer_timeout() -> void:
	
	visible = not visible;
