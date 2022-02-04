extends KinematicBody2D


#important player variables
var acceleration = 500
var terminal_velocity = 200
var minimal_velocity = 50

var can_dash = true	
var is_dashing = false
var dash_velocity = 500

var dash_direction = Vector2()

var current_x_velocity = 0
var current_y_velocity = 0

var x_direction = 0
var y_direction = 0




var dash_duration_timer
var dash_duration = .15

var dash_cooldown_timer
var dash_cooldown = 1


func _ready():
	dash_duration_timer = Timer.new()
	dash_duration_timer.set_wait_time(dash_duration)
	dash_duration_timer.connect("timeout", self, "dash_duration_over")
	add_child(dash_duration_timer)
	
	dash_cooldown_timer = Timer.new()
	dash_cooldown_timer.set_wait_time(dash_cooldown)
	dash_cooldown_timer.connect("timeout", self, "dash_cooldown_over")
	add_child(dash_cooldown_timer)
	



func _process(delta):
	
	x_direction = 0
	y_direction = 0
	
	#determin the direction pressed for both axis
	if Input.is_action_pressed("move_up"):
		y_direction += -1
	if Input.is_action_pressed("move_down"):
		y_direction += 1
		
	if Input.is_action_pressed("move_right"):
		x_direction += 1
	if Input.is_action_pressed("move_left"):
		x_direction += -1
		


	
	

	
	#first, check whether the current velocity in that direction is less than 100
	if y_direction == 1 and current_y_velocity < minimal_velocity:
		current_y_velocity = 100
	elif y_direction == -1 and current_y_velocity > -minimal_velocity:
		current_y_velocity = -100
		
	#increment velocity normally
	current_y_velocity += y_direction * acceleration * delta
	
	#do the same for x_velocity
	if x_direction == 1 and current_x_velocity < minimal_velocity:
		current_x_velocity = 100
	elif x_direction == -1 and current_x_velocity > -minimal_velocity:
		current_x_velocity = -100
		
	#increment x velocity normally
	current_x_velocity += acceleration * x_direction * delta
	
	#decelerate in the y axis
	if y_direction == 0:
		current_y_velocity = sign(current_y_velocity) * max((abs(current_y_velocity) - (acceleration * 0.5)), 0)
		
	#decelerate in the x axis
	if x_direction == 0:
		current_x_velocity = sign(current_x_velocity) * max((abs(current_x_velocity) - (acceleration * 0.5)), 0)
		
	#make sure that velocity does not exceed terminal velocity in case of linear movement
	if ( abs(current_x_velocity) > terminal_velocity):
		current_x_velocity = sign(current_x_velocity ) * terminal_velocity
	if (abs(current_y_velocity) > terminal_velocity):
		current_y_velocity = sign(current_y_velocity) * terminal_velocity
		
	#make sure that velocity does not exceed terminal velocity / sqrt(2) for diagonal movement
	if (abs(x_direction) + abs(y_direction) >= 2):
		if (abs(current_x_velocity) > (terminal_velocity / sqrt(2))):
			current_x_velocity = sign(current_x_velocity) * terminal_velocity / sqrt(2)
		if (abs(current_y_velocity) > (terminal_velocity / sqrt(2))):
			current_y_velocity = sign(current_y_velocity) * terminal_velocity / sqrt(2)
		
		
		
		
		
	#generate the movement vector
	var movement_vector = Vector2(current_x_velocity,  current_y_velocity)
	
	#check if the player is dashing 
	if Input.is_action_just_pressed("dash"):
		if can_dash:
			dash_direction = Vector2(x_direction, y_direction).normalized()
			
			if dash_direction != Vector2.ZERO:
				is_dashing = true
				dash_duration_timer.start()
	
	
	#move the character accordingly
	if not is_dashing :
		move_and_slide(movement_vector)
	else:
		set_position(get_position() + dash_direction * dash_velocity * delta)
	
	
	#detect collisions
	for i in range(get_slide_count()):
		var collision = get_slide_collision(i)
		
		if collision.collider.is_in_group("Projectile"):
			collision.collider.player_collision()
			
		#if hit a gem, call its player collision method
		elif collision.collider.is_in_group("Gem"):
			collision.collider.player_collision()
			

func dash_duration_over():
	
	dash_duration_timer.stop()

	is_dashing = false
	can_dash = false

	dash_cooldown_timer.start()
	

	
func dash_cooldown_over():
	dash_cooldown_timer.stop()

	can_dash = true
