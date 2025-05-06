class_name PlayerEvo extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const SMOOTH_SPEED = 10.0
@export var sense_horizontal = .2
@export var sense_vertical = .2
@onready var camera_mount: Node3D = $CameraMount
@onready var animation_player: AnimationPlayer = $Visuals/mixamo_base/AnimationPlayer
@onready var visuals: Node3D = $Visuals

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	animation_player.play("idle")

func _input(event) -> void:
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(- event.relative.x * sense_horizontal))
		visuals.rotate_y(deg_to_rad(event.relative.y * sense_vertical))
		camera_mount.rotate_x(deg_to_rad(- event.relative.y * sense_vertical))
		#pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		animation_player.play()
		velocity.y = JUMP_VELOCITY

	# input_dir is a Vector2
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var visual_dir = Vector3(input_dir.x, 0, input_dir.y).normalized()
	if direction:
		animation_player.play("walking")
		
		visuals.rotation.y = lerp_angle(visuals.rotation.y, atan2(-visual_dir.x, -visual_dir.z), delta * SMOOTH_SPEED)
		
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		animation_player.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
