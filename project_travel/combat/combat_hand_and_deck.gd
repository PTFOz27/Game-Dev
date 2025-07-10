extends Node2D

var deck = ["101001", "101002", "102001", "102001", "102002", "101001", "101002", "102001", "102001", "101001", "101002", "102001", "102001", "101001", "101002", "102001", "102001", "101001", "101002", "102001", "102001", "101001", "101002", "102001", "102001", "101001", "101002", "102001", "102001", "101001", "101002", "102001", "102001", "101001", "101002", "102001", "102001", ]
var hand = []
const card_default = preload("res://cards/default_card.tscn")
#Variables for adjusting hand faning
@onready var hand_node := $hand_container/hand

func _ready():
	print("✅ combat_ready() called!")
	deck.shuffle()
	draw_hand(1)
	update_hand()

func draw_hand(count):
	for i in range(count):
		if deck.size() > 0:
			var card_id = deck.pop_front()
			hand.append(card_id)
			var card = card_default.instantiate()
			hand_node.add_child(card)
			card.create_card(card_id)
			print("Created card with ID: ", card_id)
		print("🃏 Cards in hand: %d" % hand_node.get_child_count())
func update_hand() -> void:
	var hand_size = hand.size()
	var container_x = $hand_container/hand.size.x
	var container_y = $hand_container/hand.size.y
	if hand_size == 0:
		return

	if hand_size == 1:
		var card = hand_node.get_child(0)
		var x_offset = container_x / 2
		var y_offset = container_y / 2
		card.scale = Vector2(0.2, 0.2)
		card.position = Vector2(x_offset, y_offset)

	if hand_size > 1:
		for i in range(hand_size):
			var card = hand_node.get_child(i)
			print("🧩 Position:", card.position, " Size:", card.scale, " Global:", card.global_position)
