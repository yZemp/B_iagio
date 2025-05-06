## Virtual base class for all states.
## Extend this class and override its methods to implement a state.
class_name State extends Node

## Emitted when the state finishes and wants to transition to another state.
signal finished(next_state_path: String, data: Dictionary)

@export var animation_name: String
@export var move_speed: float

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var player: PlayerEvo

## Called by the state machine when receiving unhandled input events.
func handle_input(_event: InputEvent) -> void:
	pass

## Called by the state machine on the engine's main loop tick.
func frame_update(_delta: float) -> void:
	pass
 
## Called by the state machine on the engine's physics update tick.
func physics_update(_delta: float) -> void:
	pass

## Called by the state machine upon changing the active state. The `data` parameter
## is a dictionary with arbitrary data the state can use to initialize itself.
func enter() -> void:
	pass

## Called by the state machine before changing the active state. Use this function
## to clean up the state.
func exit() -> void:
	pass
