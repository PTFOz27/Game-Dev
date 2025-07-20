extends Node2D

var deck = ["101001", "101002", "102001", "102001", "102002", "101001", "101002", "102001", "102001", "101001", "101002", "102001", "102001", "101001", "101002", "102001", "102001", "101001", "101002", "102001", "102001", "101001", "101002", "102001", "102001", "101001", "101002", "102001", "102001", "101001", "101002", "102001", "102001", "101001", "101002", "102001", "102001", ]
var hand = []
const card_default = preload("res://cards/default_card.tscn")
#Variables for adjusting hand faning
@onready var hand_node := $hand_container/hand
@export var x_offset_curve: Curve
@export var y_offset_curve: Curve
@export var rotation_curve: Curve

func _ready():
	print("✅ combat_ready() called!")
	deck.shuffle()
	draw_hand(0)
	

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
		update_hand()
func update_hand() -> void:
	var hand_size = hand.size()
	var container_x = $hand_container/hand.size.x
	var container_y = $hand_container/hand.size.y
	if hand_size == 0:
		return
		
	if hand_size > 0:
		var hand_width = hand_node.size.x * 0.8
		var card_spacing = 120
		var actual_hand_width = min(hand_width, (hand_size - 1) * card_spacing)
		#var hand_height = hand_node.size.y
		for card in hand_node.get_children():
			var card_index = card.get_index()
		# Adjusting the card size relative to continer size
			var card_size = card.get_card_size()
			var card_scale = (container_x / 4) / card_size.x
			
			card.scale = Vector2(card_scale, card_scale)
			# card.set_base_scale(card.scale)
		# Offseting the card base on hand_size
			var hand_ratio = float(card_index) / max(1, hand_size - 1) # Zero-based calculation, counting from 0 to n.
			var x_offset = x_offset_curve.sample(hand_ratio) * actual_hand_width
			#var y_offset = y_offset_curve.sample(hand_ratio) * hand_height
			card.position = Vector2(x_offset, container_y / 2)
			#card.rotation = rotation_curve.sample(hand_ratio)
			print("🧩 Position:", card.position, " Size:", card.scale, " Global:", card.global_position)


func _on_button_pressed() -> void:
	draw_hand(1)
