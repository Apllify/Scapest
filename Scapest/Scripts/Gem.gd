extends KinematicBody2D


#collectible gem that tps whenever you get it (whithin bounds still)
var max_gem_count = 5 #number of times that the gem needs to be collected to go to the next scene
var current_gem_count

var scene_to_load = "res://Scenes/Level2.tscn"


var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	current_gem_count = max_gem_count


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func player_collision():
	current_gem_count -= 1
	
	if current_gem_count > 0:	
		var new_x = rng.randi_range(20, 300) 
		var new_y = rng.randi_range(20, 160)
		
		set_position(Vector2(new_x, new_y))
	else:
		#load the next scene for the player
		get_tree().change_scene(scene_to_load)
		
	
