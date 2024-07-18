extends Node2D

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.is_in_group("player"):
		# Assuming you have a reference to the timer script
		var timer_script = get_node("res://scenes/stopwatch.gd")
		timer_script._on_body_entered(self)
