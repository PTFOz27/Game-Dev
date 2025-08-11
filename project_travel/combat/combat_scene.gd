extends Node2D

func _ready():
	hand_manager.hand_node = $hand_container/hand
	hand_manager.player_deck = ["101001", "101002", "102001", "102001", "102002", "101001", "101002", "102001", "102001", "101001", "101002", "102001", "102001", "101001", "101002", "102001", "102001", "101001", "101002", "102001", "102001", "101001", "101002", "102001", "102001", "101001", "101002", "102001", "102001", "101001", "101002", "102001", "102001", "101001", "101002", "102001", "102001", ]
	hand_manager.player_hand = []
	hand_manager.update_hand()
func button_draw_card() -> void:
	card_functions.draw_card(1)
