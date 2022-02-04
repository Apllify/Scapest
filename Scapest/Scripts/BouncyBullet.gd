extends KinematicBody2D

var x_velocity = 0	
var y_velocity  = 0

var displacement_vector 

var does_bounce = false

var lifespan = 5
var lifespan_timer


# Called when the node enters the scene tree for the first time.
func _ready():
	displacement_vector = Vector2(x_velocity,y_velocity)
	
	lifespan_timer = Timer.new()
	lifespan_timer.set_wait_time(lifespan)
	lifespan_timer.connect("timeout", self, "lifespan_over")
	add_child(lifespan_timer)
	lifespan_timer.start()



func _process(delta):


	
	#move by that amount 
	move_and_slide(displacement_vector)
	
	for i in range(get_slide_count()):
		var collision = get_slide_collision(i)
		
		#if it's a player collision, disappear
		if collision.collider.is_in_group("Player") :
			player_collision()
			
		#if it's a wall or bullet collision, reverse the direction that made it collide
		elif collision.collider.is_in_group("Wall"):
			if does_bounce:
				displacement_vector = displacement_vector.bounce(collision.normal)
			else:
				queue_free()
				
		elif collision.collider.is_in_group("Projectile"):
			displacement_vector = displacement_vector.bounce(collision.normal)
			
		elif collision.collider.is_in_group("Gem"):
			queue_free()

func player_collision():
	get_tree().reload_current_scene()
	
func lifespan_over():
	queue_free()


