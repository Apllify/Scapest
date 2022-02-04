extends KinematicBody2D

var firing_rate = 1
var firing_timer



var bullet_speed = 100
var bullet_lifespan = 5
var bullet_shot_count=  1
var does_bounce = false

var shot_iterations_count = 0

var player_character
var self_position

var bouncy_bullet_class
var bullet_storage
var firing_spot 


# Called when the node enters the scene tree for the first time.
func _ready():
	#get the two info references
	self_position = get_position()
	
	player_character = get_tree().get_root().get_node("Scene").get_node("PlayerCharacter")
	
	#instantiate the firing timer
	firing_timer = Timer.new()
	firing_timer.set_wait_time(firing_rate)
	firing_timer.connect("timeout", self, "fire")
	add_child(firing_timer)
	firing_timer.start()
	
	#retrieve the bouncy bullet class for instantiation
	bouncy_bullet_class = load("res://Prefabs/BouncyBullet.tscn")
	
	#retrieve the parent node
	bullet_storage = get_tree().get_root().get_node("Scene").get_node("Bullet Storage")

	
	#retrieve the firing spot for bullets
	firing_spot = get_node("FiringSpot")



func _process(delta):
	
	var player_position = player_character.get_position()
	
	var x_distance=  player_position.x - self_position.x
	var y_distance =  self_position.y - player_position.y
	
	var angle = get_rotation()

	if y_distance != 0:
		angle = atan(x_distance / y_distance)
	
	if y_distance < 0:
		angle += PI
	
	set_rotation(angle)
	
func fire():
	firing_timer.stop()

	#generate a new bouncy bullet instance
	var bouncy_bullet = bouncy_bullet_class.instance()
	
	#give it the proper velocity
	bouncy_bullet.x_velocity = sin(get_rotation()) * bullet_speed
	bouncy_bullet.y_velocity = -cos(get_rotation()) * bullet_speed
	
	#give it the proper lifespan
	bouncy_bullet.lifespan = bullet_lifespan
	
	#give it the proper bounce property
	bouncy_bullet.does_bounce = does_bounce
	
	#give it the proper starting position
	bouncy_bullet.set_position(firing_spot.get_global_position())
	
	#add it to the parent
	bullet_storage.add_child(bouncy_bullet)
	
	shot_iterations_count += 1
	
	if shot_iterations_count == bullet_shot_count:
		#reset timer normally
		shot_iterations_count = 0 
		firing_timer.start(firing_rate)
	else:
		firing_timer.start(0.2)
	

	
	
