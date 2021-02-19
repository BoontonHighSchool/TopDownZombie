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
	spawn_zombies(2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	zCount = zContainer.get_child_count()
	print("zCount ",zCount, "   Level: ",level)
	$HUD/Label.set_text(str(zCount))
	if zContainer.get_child_count() == 0:
		level += 1
		spawn_zombies(level * 1)
		
func spawn_zombies(num):
	for i in range(num):
		var z = zombie.instance()
		z.add_to_group("zombies")
		get_tree().call_group("zombies", "set_player", $Player)
		z.set_position(Vector2(rand_range(100, screensize.x-100),rand_range(100, screensize.y-100)))
		zContainer.add_child(z)
