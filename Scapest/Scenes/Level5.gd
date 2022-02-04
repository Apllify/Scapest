extends Node2D






func _ready():
	print("GO")
	
	#first, properly set the level name in level count 
	var level_count_node = get_tree().get_root().get_node("Scene").get_node("Level Count")
	level_count_node.set_text("Level 5")
	
	#then, instantiate the middle gem
	var gem_class = load("res://Prefabs/Gem.tscn")
	
	var gem = gem_class.instance()
	
	gem.set_position(Vector2(160, 90))
	
	gem.max_gem_count = 7
	gem.scene_to_load = "res://Scenes/Level6.tscn"
	
	#add it to the scene
	add_child(gem)
	
	#then, instantiate every cannon one by one
	var cannon_class = load("res://Prefabs/BouncyCannon.tscn")
	
	var cannon1 = cannon_class.instance()
	
	cannon1.set_position(Vector2(160, 180))	
	
	cannon1.firing_rate = 1.5
	cannon1.bullet_speed = 200
	cannon1.bullet_lifespan = 1
	cannon1.bullet_shot_count = 1
	cannon1.does_bounce = false
	
	var cannon2 = cannon_class.instance()
	
	cannon2.set_position(Vector2(160, 0))	
	
	cannon2.firing_rate = 1.5
	cannon2.bullet_speed = 200
	cannon2.bullet_lifespan = 1
	cannon2.bullet_shot_count = 1
	cannon2.does_bounce = false
	
	var cannon3 = cannon_class.instance()
	
	cannon3.set_position(Vector2(0, 90))	
	
	cannon3.firing_rate = 1.5
	cannon3.bullet_speed = 200
	cannon3.bullet_lifespan = 1
	cannon3.bullet_shot_count = 1
	cannon3.does_bounce = false
	
	var cannon4 = cannon_class.instance()
	
	cannon4.set_position(Vector2(320, 90))	
	
	cannon4.firing_rate = 1.5
	cannon4.bullet_speed = 200
	cannon4.bullet_lifespan = 1
	cannon4.bullet_shot_count = 1
	cannon4.does_bounce = false
	
	#add them to the scene
	get_tree().get_root().get_node("Scene").get_node("Cannons").add_child(cannon1)
	get_tree().get_root().get_node("Scene").get_node("Cannons").add_child(cannon2)
	get_tree().get_root().get_node("Scene").get_node("Cannons").add_child(cannon3)
	get_tree().get_root().get_node("Scene").get_node("Cannons").add_child(cannon4)
