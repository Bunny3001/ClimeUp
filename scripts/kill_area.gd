#extends Area2D
#
#@export var spawn_point: Node2D  # Assign a SpawnArea in the Inspector
#
#func _on_body_entered(body: Node2D) -> void:
	#if body is CharacterBody2D and spawn_point:  # Ensure it's the player and a spawn is set
		#body.global_position = spawn_point.global_position  # Move to assigned spawn point
#extends Area2D
#
## Expose a variable in the Inspector to link the SpawnArea
#@export var spawn_area: Node2D
#
#func _on_body_entered(body: Node2D) -> void:
	## Check if the colliding body is the player (assumed to be a CharacterBody2D)
	#if body is CharacterBody2D and spawn_area:
		## Teleport the player to the linked spawn_area's position
		#body.global_position = spawn_area.global_position
extends Area2D

@export var spawn_area: Node2D

func _ready() -> void:
	# If spawn_area is not assigned manually in the Inspector, set it to the parent node.
	if spawn_area == null:
		spawn_area = get_parent()

func _on_body_entered(body: Node2D) -> void:
	# Check if the colliding body is the player (assumed to be a CharacterBody2D)
	if body is CharacterBody2D and spawn_area:
		# Teleport the player to the linked spawn_area's position
		body.global_position = spawn_area.global_position
