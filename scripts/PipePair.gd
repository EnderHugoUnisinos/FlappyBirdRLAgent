class_name PipePair

extends Node2D

var speed = 300.0

func _ready():
	var gap_y = round(randf_range(150, 450))
	print(gap_y)
	$TopPipe.position.y = gap_y - 350
	$BottomPipe.position.y = gap_y + 350
	$ScoreArea.position.y = gap_y

func _physics_process(delta):
	position.x -= speed * delta
	if position.x < -200:
		queue_free()

func get_gap_y() -> float:
	return $TopPipe.position.y + 350  
