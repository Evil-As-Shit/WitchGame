extends KinematicBody2D

const ACCELERATION = 500
const MAX_SPEED = 50
const FRICTION = 500

var target
var inventory = []
var canMove = true
var canInteract = false
var interacting = false
var velocity = Vector2.ZERO
var interupt = false

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var rayCast = $RayCast2D
onready var dialogue = get_node("../../DialogueParser")
onready var ui = get_node("../../UI/Control")

func _ready():
	set_process_input(true)

func _physics_process(delta):
	if(ui.inUI):
		animationState.travel("Phone")
	if(canMove):
		Movement(delta)
	if (dialogue.panelNode.is_visible() and dialogue.texting):
		ui.get_node("NinePatchRect/nextIcon").play("Rest")
		ui.get_node("NinePatchRect/nextIcon").show()
	elif (dialogue.panelNode.is_visible() and !dialogue.texting):
		ui.get_node("NinePatchRect/nextIcon").play("Next")
	else:
		ui.get_node("NinePatchRect/nextIcon").hide()

func _input(_event):
	if(Input.is_action_just_pressed("e")):
		print("interacting: ", interacting)
		print("canInteract: ", canInteract)

		if(dialogue.texting):
#			print("texting rn")
			interupt = true
		elif(interacting and canInteract):
#			print("can interact and interacting")
			dialogue._on_button_pressed(target)
		elif(!canInteract and dialogue.panelNode.is_visible() and !dialogue.texting):
#			print("cant interact but in dialogue 'bug'")
			dialogue._on_button_pressed(target)
		elif(!canInteract and !interacting or ui.inUI):
			pass
#			print("cant interact, not interacting")
#			interacting = false
#			canMove = true
		elif(target == null):
			pass
#			print("no target")
		else:
			canMove = false
			interacting = true
			print("Interacting with " + target.get_name())
			get_node("../../DialogueParser").init_dialogue(target.get_name())
			target.action(inventory)
			if (target.is_in_group("Item") and inventory.find(target.get_name()) < 0):
				inventory.append(target.get_name())
				print(inventory)

func _on_Area2D_body_enter(body, obj):
	if(body.get_name() == "Player"):
		canInteract = true
		target = obj
	if(rayCast.is_colliding()):
		pass
	else:
		pass
func _on_Area2D_body_exit(body, _obj):
	if(body.get_name() == "Player"):
		canInteract = false
		target = null

func Movement(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_vector = input_vector.normalized()
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Phone/blend_position", input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		rayCast.set_cast_to(velocity)
	else:
		animationState.travel("Idle")
#		velocity = velocity.move_toward(Vector2.ZERO,FRICTION * delta)
		velocity = Vector2.ZERO
	velocity = move_and_slide(velocity)
