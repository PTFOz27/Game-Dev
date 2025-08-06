extends Node2D
const load_hand_and_deck = preload("res://combat/load_hand_and_deck.gd")
var hand_loader = load_hand_and_deck.new()

func _ready():
	hand_loader.update_hand()
func button_draw_card() -> void:
	hand_loader.draw_card(1)
