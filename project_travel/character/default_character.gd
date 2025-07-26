extends Node2D

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D

enum CharacterState { IDLE, DAMAGED, DODGE }
var current_state: CharacterState = CharacterState.IDLE

func _ready():
	play_idle()

func play_idle():
	current_state = CharacterState.IDLE
	anim_sprite.play("idle")

func play_hurt():
	current_state = CharacterState.DAMAGED
	anim_sprite.play("damaged")

func play_dodge():
	current_state = CharacterState.DODGE
	anim_sprite.play("dodge")
