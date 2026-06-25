extends AIController2D

@onready var main = get_parent() as Main
@onready var bird = get_node("../Bird")

var last_score = 0
var last_highscore = 0

func get_obs() -> Dictionary:
	if bird == null:
		bird = get_node("../Bird")
		if bird == null:
			return {"obs": [0.0, 0.0, 0.0, 0.0]}

	var pipes = get_tree().get_nodes_in_group("pipes")
	var next_gap = 0.0
	var next_dist = 1000.0

	for pipe in pipes:
		var dist = pipe.position.x - bird.position.x
		if dist > 0 and dist < next_dist:
			next_dist = dist
			next_gap = pipe.get_gap_y()
	
	var relative_y = (bird.position.y - next_gap) / 640
	
	return {
		"obs": [
			relative_y,
			bird.position.y / 640,
			bird.velocity.y / 1000.0,
			#next_dist / 1152.0,
			#next_gap / 640
		]
	}

func get_reward() -> float:
	if bird.is_dead:
		return -3.5
	var reward = 0.01
	if main.score > last_score:
		reward += 1.0
		last_score = main.score
		if main.highscore > last_highscore:
			last_highscore = main.highscore
		#	reward += 5
	return reward

func get_action_space() -> Dictionary:
	return {"action": {"size": 2, "action_type": "discrete"}}

func set_action(action) -> void:
	var action_value = action["action"]
	if action_value == 1:
		bird.jump()

func get_done() -> bool:
	return bird.is_dead 

func on_reset():
	print("reset!")
	last_score = 0
	#main.reset_game()
