extends TextureRect;
class_name SelectBox;

@export var timer : Timer;

func _on_timer_timeout():
	
	visible = !visible;

func start_flash() -> void:
	
	timer.start();

func stop_flash() -> void:
	
	timer.stop();
	show();
