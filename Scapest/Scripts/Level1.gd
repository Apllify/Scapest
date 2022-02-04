extends Node2D






func _ready():
	print("GO")
	
	#first, properly set the level name in level count 
	var level_count_node = get_tree().get_root().get_node("Scene").get_node("Level Count")
	level_count_node.set_text("Level 1")
	
	#then, instantiate the middle gem
	var gem_class = load("res://Prefabs/Gem.tscn")
	
	var gem = gem_class.instance()
	
	gem.set_position(Vector2(160, 90))
	
	gem.max_gem_count = 5
	gem.scene_to_load = "res://Scenes/Level2.tscn"
	
	#add it to the scene
	add_child(gem)
	
	#then, instantiate every cannon one by one
	var cannon_class = load("res://Prefabs/BouncyCannon.tscn")
	
	var cannon1 = cannon_class.instance()
	
	cannon1.set_position(Vector2(160, 180))	
	
	cannon1.firing_rate = 1
	cannon1.bullet_speed = 100
	cannon1.bullet_lifespan = 5
	cannon1.bullet_shot_count = 1
	cannon1.does_bounce = false
	
	#add them to the scene
	get_tree().get_root().get_node("Scene").get_node("Cannons").add_child(cannon1)
