extends Node3D

@export var speed: float=15.0
@export var tile_length: float=40.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var tiles=get_children()
	var tracklength=tile_length*tiles.size()
	
	for tile in tiles:
		tile.position.z+=speed*delta
		if tile.position.z>tile_length:
			tile.position.z-=tracklength
