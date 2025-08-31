extends Node2D
#this script contains animations and visual effects; and default values.
#see .tres files for permanent and temporary combat *actual* values
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var health_bar: TextureProgressBar = $HealthBar
var ally_id: String = ""
var max_hp: int
var current_hp: int
var attack: int
var res: int
var dodge: int
var crit: int
var combat_position: int		# combat-only
var statuses: Array = []		# combat-only




func _ready():
	set_ally_data(ally_id)
func set_ally_data(id: String):
	var data = ally_data.get_ally_stats(id)
	print(data)
	set_ally_visuals(id)
	max_hp = data.get("base_hp")
	current_hp = data.get("current_hp")
	attack = data.get("attack")
	res = data.get("resistance")
	dodge = data.get("dodge")
	crit = data.get("critical_chance")
	# Wait until health_bar is ready
	if health_bar != null:
		set_ally_visuals(id)
func set_ally_visuals(id: String):
	health_bar.max_value = max_hp
	health_bar.value = current_hp


#Character Animation State
enum CharacterState { IDLE, DAMAGED, DODGE }
# const IDLE = 0 
# const etc....
var current_state: CharacterState = CharacterState.IDLE

func play_idle():
	current_state = CharacterState.IDLE
	anim_sprite.play("idle")

func play_hurt():
	current_state = CharacterState.DAMAGED
	anim_sprite.play("damaged")

func play_dodge():
	current_state = CharacterState.DODGE
	anim_sprite.play("dodge")


func _on_character_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:

	if event is InputEventMouseButton and event.pressed:
		print("Input event received")  # Check if this appears
		card_functions.select_character(self)

func highlight():
		modulate = Color(1, 1, 0.5)  # light yellow
