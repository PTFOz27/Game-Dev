extends Node2D

func _ready():
	hand_manager.hand_node = $hand_container/hand
	hand_manager.player_deck = ["101001", "101002", "102001", "102001", "102002", "101001", "101002", "102001", "102001", "101001", "101002", "102001", "102001", "101001", "101002", "102001", "102001", "101001", "101002", "102001", "102001", "101001", "101002", "102001", "102001", "101001", "101002", "102001", "102001", "101001", "101002", "102001", "102001", "101001", "101002", "102001", "102001", ]
	hand_manager.player_hand = []
	hand_manager.update_hand()
	load_character()
func button_draw_card() -> void:
	card_functions.draw_card(1)
func button_play_card() -> void:
	card_functions.play_card("101001")

func load_character():
	var ally_scene = preload("res://character/default_character.tscn")
	var ally_instance = ally_scene.instantiate()
	$ally_container/ally_container1.add_child(ally_instance)
	
