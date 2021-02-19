extends KinematicBody2D

const MOVE_SPEED = 300
var rayLength = 100

onready var raycast = $RayCast2D

func _ready():
	yield(get_tree(), "idle_frame")
	get_tree().call_group("zombies", "set_player", self)

func _physics_process(delta):
	set_process(true)
	var move_vec = Vector2()
	if Input.is_action_pressed("move_up"):
		move_vec.y -= 1
	if Input.is_action_pressed("move_down"):
		move_vec.y += 1
	if Input.is_action_pressed("move_left"):
		move_vec.x -= 1
	if Input.is_action_pressed("move_right"):
		move_vec.x += 1
	move_vec = move_vec.normalized()
	move_and_collide(move_vec * MOVE_SPEED * delta)
	
	var look_vec = get_global_mouse_position() - global_position
	global_rotation = atan2(look_vec.y, look_vec.x)
	
	if Input.is_action_just_pressed("shoot"):
		var coll = raycast.get_collider()
		if raycast.is_colliding() and coll.has_method("kill"):
			coll.kill()
	

	if move_vec.x != 0:
		rayLength = 100
	elif move_vec.y != 0:
		rayLength = 100
	else:
		rayLength += 0.5
		
	raycast.set_cast_to(Vector2(rayLength, 0))
	
	#Set Crosshair Image Placement
	$CrossHair.position.x = rayLength
	$CrossHair.position.y = raycast.position.y
	#Set Line2D Start and end points
	var from = Vector2($Position2D.position.x,0)
	var to = Vector2($CrossHair.position.x,0)
	#Run createLine function to draw the line
	createLine(from, to)
	
#	$Label.text = ("Ray " + str(rayLength) + "move_vec " + str(move_vec))
	
func kill():
	#When you die, reload current level
#	get_tree().reload_current_scene()
	#When you die, go back to level 1
	get_tree().change_scene("res://Level 1.tscn")

func createLine(from, to):
	$Line2D.clear_points()
	$Line2D.add_point(from)
	$Line2D.add_point(to)
