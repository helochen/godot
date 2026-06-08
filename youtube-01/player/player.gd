extends CharacterBody2D

const SPEED = 100.0
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var play_back = animation_tree.get("parameters/StateMachine/playback") as AnimationNodeStateMachinePlayback

var input_vector: = Vector2.ZERO
var last_direction: = Vector2(0, -1)

func _ready() -> void:
	animation_tree.active = true

func _physics_process(delta: float) -> void:
	var state = play_back.get_current_node()
	if state == "MoveState":
		input_vector = Input.get_vector("run_left" , "run_right" , "run_up" , "run_down")
		if input_vector != Vector2.ZERO:
			var direction_vector = Vector2(input_vector.x  , -input_vector.y)
			update_blend_positions(direction_vector)
		if Input.is_action_just_pressed("attack"):
			play_back.travel("AttackState")
	elif state == "AttackState":
		pass
	velocity = input_vector * SPEED
	move_and_slide() 
	


func update_blend_positions(direction_vector: Vector2) -> void:
	animation_tree.set("parameters/StateMachine/MoveState/RunState/blend_position" , direction_vector)
	animation_tree.set("parameters/StateMachine/MoveState/StandState/blend_position" , direction_vector)
	animation_tree.set("parameters/StateMachine/AttackState/blend_position" , direction_vector)
	
