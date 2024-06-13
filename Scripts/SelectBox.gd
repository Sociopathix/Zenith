extends TextureRect;
class_name SelectBox;

@export var timer : Timer;

func start_flashing() -> void:
	
	timer.start();

func stop_flashing() -> void:
	
	timer.stop();
	show();

func _on_timer_timeout() -> void:
	
	visible = !visible;
