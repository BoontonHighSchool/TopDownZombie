extends Node2D

onready var zombie = preload("res://Zombie.tscn")
onready var zContainer = get_node("zContainer")

onready var tilemap = $TileMap

var screensize
var zCount = 0
var level = 1
var valid_cells

func _ready():
	randomize()
	set_process(true)
	screensize = get_viewport().get_visible_rect().size
	get_valid_cells() # Compute the valid cells in the tilemap
	spawn_zombies(5)

func get_valid_cells() -> void:
	valid_cells = []
	for cell in tilemap.get_used_cells():
		if tilemap.get_cellv(cell) != 3:	# 3 == wall
			valid_cells.append(cell)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	zCount = zContainer.get_child_count()
	# print("zCount ",zCount, "   Level: ",level)
	$HUD/Label.set_text(str(zCount))
	if zContainer.get_child_count() == 0:
		level += 1
		spawn_zombies(level * 1)
		
func spawn_zombies(num):
	var cells_to_use = valid_cells.duplicate() # Copy the cells
	cells_to_use.shuffle()  # Randomly shuffle them
	var cell_size = tilemap.cell_size
	for _i in range(num):
		var z = zombie.instance()
		z.add_to_group("zombies")
		get_tree().call_group("zombies", "set_player", $Player)
		z.set_position(cells_to_use.pop_front() * cell_size + cell_size/2.0)
		zContainer.add_child(z)
