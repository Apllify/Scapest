extends Label


var fade_speed = 100.0/255.0



func _ready():
	pass # Replace with function body.



func _process(delta):
	var cur_mod = get_modulate()
	var new_modulate = Color(cur_mod.r, cur_mod.g, cur_mod.b, cur_mod.a - (delta * fade_speed))
	set_modulate(new_modulate)	
