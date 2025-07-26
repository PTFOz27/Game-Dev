extends Node2D

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
enum EnemyState { IDLE, DAMAGED, DODGE }
var current_state: EnemyState = EnemyState.IDLE

@onready var health_bar: TextureProgressBar = $HealthBar
var current_health

func _ready():
	play_idle()
func play_idle():
	current_state = EnemyState.IDLE
	anim_sprite.play("idle")

func play_hurt():
	current_state = EnemyState.DAMAGED
	anim_sprite.play("damaged")

func play_dodge():
	current_state = EnemyState.DODGE
	anim_sprite.play("dodge")
	
