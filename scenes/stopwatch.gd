extends CanvasLayer

var time = Global.speedrun_time
var timer_paused = false

func _physics_process(delta):
	if not timer_paused:
		time = float(time) + delta
		update_ui()

func update_ui():
	var minutes = int(time) / 60
	var seconds = int(time) % 60
	var milliseconds = int((time - int(time)) * 100)
	
	var formatted_time = str(minutes).pad_zeros(2) + ":" + str(seconds).pad_zeros(2) + "." + str(milliseconds).pad_zeros(2)
	
	Global.speedrun_time = formatted_time
	$Label.text = formatted_time

func _on_body_entered(body):
	if body.is_in_group("pause_trigger"):
		timer_paused = true
		update_ui()

# Function to handle collision with the sprite body
func _on_Player_body_entered(body):
	if body.is_in_group("pause_trigger"):
		_on_body_entered(body)


