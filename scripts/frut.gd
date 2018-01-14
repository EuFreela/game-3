extends RigidBody2D

onready var shape = get_node("Shape")
onready var sprit0 = get_node("Sprit0")
onready var body1 = get_node("Body1")
onready var body2 = get_node("Body2")
onready var sprit1 = get_node("Body/Sprit1")
onready var sprit2 = body2.get_node("Sprite2")

var cortada = false
signal score
signal life

func _ready():
	randomize()
	#born(Vector2(640,800))
	set_process(true)

func _process(delta):
	if get_pos().y > 800:
		print("perdeu")
		emit_signal("life")
		queue_free()
	if body1.get_pos().y > 800:
		print("free!")
		queue_free()

func born(inipos):
	set_pos(inipos)
	var inivel = Vector2(0,rand_range(-1000,-800))
	if inipos.x < 640:
		inivel = inivel.rotated(deg2rad(rand_range(0,-30)))
	else:
		inivel = inivel.rotated(deg2rad(rand_range(0,30)))
		
	set_linear_velocity(inivel)
	set_angular_velocity(rand_range(-10,10))

func cut():
	if cortada: return
	cortada = true
	emit_signal("score")
	set_mode(MODE_KINEMATIC)
	sprit0.queue_free()
	shape.queue_free()
	body1.set_mode(MODE_RIGID)
	body2.set_mode(MODE_RIGID)
	body1.apply_impulse(Vector2(0,0), Vector2(-100,0).rotated(get_rot()))
	body2.apply_impulse(Vector2(0,0), Vector2(100,0).rotated(get_rot()))
	body1.set_angular_velocity(get_angular_velocity())
	body2.set_angular_velocity(get_angular_velocity())
	
