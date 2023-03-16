extends StaticBody2D

onready var player = get_node("../Player")
onready var animationState = player.animationTree.get("parameters/playback")

func _ready():
	set_process(true)

func _process(_delta):
	if Input.is_action_pressed("e"):
		# Check if the player is within a certain distance of this StaticBody2D
		if player.position.distance_to(position) < 5:
			# Change the player's animation to "sit"
			animationState.travel("Sitting")
			# Move the player to the StaticBody2D's position
			player.position = position
