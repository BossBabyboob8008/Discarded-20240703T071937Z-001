extends CharacterBody2D
# These are all of the variable in the code, they keep track 
# of values that you can make do things. for emaxple if i set 
# speed to = velocity.x than i will move in that direction at 
# the velocity of that value
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
@onready var jump_cool_down: Timer = $"Jump cool down"
var was_on_wall = is_on_wall()


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
# This code changes the animation state for direction for example if the character 
# is moving to the left the animator will filp the sprite to face left 
# and vice versa for right movement.
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
# This code will check if the player is on the floor and add velocity pushing the 
# player down until they hit the floor simulating gravity.
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed
# This code allows the character to jump off of walls for example if you are pressing right to run into a wall and jump is pressed 
# then the character will gain velocity that is grater than the normal jump velocity pushing the character up and to the right if its 
# a left wall and vise versa. There is also code that states that if the Cyotye timer is not finished you can still wall jump if you 
# arent on a wall
	if Input.is_action_pressed("right")  and (is_on_wall() or !jump_cool_down.is_stopped()) and Input.is_action_just_pressed("jump"):
		velocity.y = -wall_jump_pushback                                                              
		velocity.x = -wall_jump_pushback
	if Input.is_action_pressed("left") and (is_on_wall() or !jump_cool_down.is_stopped()) and Input.is_action_just_pressed("jump"):
		velocity.y = -wall_jump_pushback
		velocity.x = wall_jump_pushback                                     
	else:
		wall_slide(delta)
# This code allows the player to Slide down a wall slowly by moving into it, it does 
# this by checking if the player is on a wall and is not on the floor and if the input 
# pressed is pushing against the wall than it will slow the velocity of gravity.
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
# This code allows the character to run left and right by adding velocity to the
# left or right depending on which input you are pressing
	var direction = Input.get_axis("left", "right")
	if direction: 
		velocity.x = move_toward(velocity.x, direction * speed, acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, acceleration/2)

	update_state()
	update_animation(direction)
	move_and_slide()
# This code will start a Cyote timer if the player is not on the floor ans 
# if is not on a wall that allows the character to jump when they arent on a wall
	if was_on_wall && !is_on_floor() && !is_on_wall():
		jump_cool_down.start()
