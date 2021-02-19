extends Node2D

onready var zombie = preload("res://Zombie.tscn")
onready var zContainer = get_node("zContainer")

var screensize
var zCount = 0
var level = 1

func _ready():
	randomize()
	set_process(true)
	screensize = get_viewport().get_visible_rect().size
#	spawn_zombies(1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	zCount = zContainer.get_child_count()
	print("zCount ",zCount)
#	$HUD/Label.set_text(str(zCount))
	if zContainer.get_child_count() == 0:
		print("WIN")
#		level += 1
#		spawn_zombies(level * 1)
		
#func spawn_zombies(num):
#	for i in range(num):
#		var z = zombie.instance()
#		zContainer.add_child(z)
#		z.add_to_group("zombies")
#		z.global_position(Vector2(100,100))
#		z.position(Vector2(rand_range(100, screensize.x-100),rand_range(100, screensize.y-100)))
