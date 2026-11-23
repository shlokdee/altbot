extends CharacterBody3D


#const SPEED = 5.0
const LANE_WIDTH=2.5
const GRAVITY=22.0
const JUMP_VELOCITY = 8.
var current_lane = 0
var is_ducking=false
var duck_timer=0


@onready var mesh=$MeshInstance3D
@onready var collision=$CollisionShape3D

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y-=GRAVITY*delta
		if Input.is_action_just_pressed("duck"):
			velocity.y-=30
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		if is_ducking:
			end_ducking()
		velocity.y=JUMP_VELOCITY
	
	if Input.is_action_just_pressed("duck") and is_on_floor() and not is_ducking:
		start_ducking()
		
	if is_ducking:
		duck_timer-=delta
		if duck_timer<=0:
			end_ducking()
		
	
	if Input.is_action_just_pressed("left") and current_lane>-1:
		current_lane-=1
	if Input.is_action_just_pressed("right") and current_lane<1:
		current_lane+=1
	
	var target_x=current_lane*LANE_WIDTH
	
	velocity.x=(target_x-position.x)*15.0
	move_and_slide()
	
func start_ducking() ->void:
	is_ducking=true
	duck_timer=0.65
	mesh.scale.y=0.5
	collision.scale.y=0.5
	
func end_ducking() ->void:
	is_ducking=false
	mesh.scale.y=1
	collision.scale.y=1
		
