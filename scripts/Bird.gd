extends CharacterBody2D

signal died

const GRAVITY = 1000.0
const JUMP_FORCE = -450.0

var is_dead = false

func _ready():
	position = Vector2(150, 300)

func _physics_process(delta):
	if is_dead:
		return
	velocity.y += GRAVITY * delta
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		var collider = collision.get_collider()
		if collider and collider.get_parent() is PipePair:
			die()
	
	if position.y > 620 or position.y < 0:
		die()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		jump()

func jump():
	if not is_dead:
		velocity.y = JUMP_FORCE

func die():
	if is_dead:
		return
	is_dead = true
	velocity = Vector2.ZERO
	died.emit()
