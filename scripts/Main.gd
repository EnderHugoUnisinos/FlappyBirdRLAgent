class_name Main
extends Node2D

@onready var bird = $Bird
@onready var spawn_timer = $SpawnTimer

@onready var score_label = $Score
@onready var highscore_label = $HighScore

@onready var ai = $AIController2D

var score = 0
var highscore = 0
var game_over = false
var reset_timer: Timer

func _ready():
	spawn_timer.timeout.connect(_spawn_pipe)
	bird.died.connect(_on_bird_died)
	spawn_timer.start()
	
	reset_timer = Timer.new()
	reset_timer.one_shot = true
	reset_timer.wait_time = 0.1
	add_child(reset_timer)
	reset_timer.timeout.connect(_delayed_reset)

func _spawn_pipe():
	if game_over:
		return
	var pipe_scene = preload("res://scenes/PipePair.tscn")
	var pipe = pipe_scene.instantiate()
	pipe.position = Vector2(1152, 0)
	add_child(pipe)
	pipe.get_node("ScoreArea").body_entered.connect(_on_score)

func _on_score(body):
	if not game_over and body.name == "Bird":
		score += 1
		score_label.text = str(score)
		if score > highscore:
			highscore = score
			highscore_label.text = str(highscore)

func _on_bird_died():
	game_over = true
	spawn_timer.stop()
	reset_timer.start()

func _delayed_reset():
	reset_game()
	
	if ai.has_method("_on_reset"):
		ai._on_reset()

func reset_game():
	game_over = false
	score = 0
	score_label.text = "0"
	bird.is_dead = false
	bird.position = Vector2(150, 300)
	bird.velocity = Vector2.ZERO
	
	for child in get_children():
		if child is PipePair:
			child.queue_free()
			
	_spawn_pipe()
	spawn_timer.start()
