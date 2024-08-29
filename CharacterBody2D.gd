extends CharacterBody2D

@onready var all_interactions = []
@export var speed = 100.0
@export var jump_speed = -300.0
@export var acceleration : float = 15
@export var jumps = 1
const wall_slide_pull_down = 50
const wall_jump_pushback = 300
var is_wall_sliding = false
enum state{IDLE, Run, jump, hurt, Wallgrab}
var anim_state = state.IDLE
@onready var animator = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var InteractionLabel = $"Interaction Components/Label"

func update_state():
	if anim_state == state.hurt:
		return
	if is_on_floor():
		if velocity == Vector2.ZERO:
			anim_state = state.IDLE
		elif velocity.x != 0:
			anim_state = state.Run
	else:
		if velocity.y < 0:
			anim_state = state.jump
	if is_on_wall() and not is_on_floor():
		anim_state = state.Wallgrab

func update_animation(direction):
	if direction > 0:
		animator.flip_h = true
	elif direction < 0:
		animator.flip_h = false
	match anim_state:
		state.IDLE:
			animation_player.play("IDLE")
		state.Run:
			animation_player.play("Run")
		state.jump:
			animation_player.play("jump")
		state.hurt:
			animation_player.play("hurt")
		state.Wallgrab:
			animation_player.play("Wallgrab")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed

	if is_on_wall() and Input.is_action_pressed("right") and Input.is_action_just_pressed("jump"):
		velocity.y = -wall_jump_pushback
		velocity.x = -wall_jump_pushback
	if is_on_wall() and Input.is_action_pressed("left") and Input.is_action_just_pressed("jump"):
		velocity.y = -wall_jump_pushback
		velocity.x = wall_jump_pushback
	else:
		wall_slide(delta)

func wall_slide(delta):
	if is_on_wall() and !is_on_floor():
		if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
			is_wall_sliding = true
		else:
			is_wall_sliding = false
	else:
		is_wall_sliding = false
	
	if is_wall_sliding:
		velocity.y += (wall_slide_pull_down * delta)
		velocity.y = min(velocity.y, wall_slide_pull_down)

	var direction = Input.get_axis("left", "right")
	if direction: 
		velocity.x = move_toward(velocity.x, direction * speed, acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, acceleration/2)

	update_state()
	update_animation(direction)
	move_and_slide()
