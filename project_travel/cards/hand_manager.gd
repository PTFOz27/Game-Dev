extends Node2D
const card_default = preload("res://cards/default_card.tscn")
var card_controller = preload("res://cards/card_control.gd").new()
@onready var hand_node = null
var player_deck: Array = []
var player_hand: Array = []
#------------Below is underlying function for interactive elements for above------------------#
var x_offset_curve = preload("res://cards/card_resources/x_offset_curve.tres") #Curve for new_card x-offset

func update_hand() -> void:
	if hand_node == null:
		push_error("hand_node not set!")
		return
	var card_count = player_hand.size()
	var container_x = hand_node.size.x
	if container_x == null:
		print('container null')
		return
	var container_y = hand_node.size.y
	
	if card_count == 0:
		return
		
	if card_count > 0:

		for new_card in hand_node.get_children():
	#Get the card_size to make relative adjustments
			var original_card_size = new_card.get_card_size() #Get the size of the new card with get_card_size() in card_loader script
	#Adjust new_card size to fit inside container
			var new_card_scale = container_y / original_card_size.y
			new_card.scale = Vector2(new_card_scale,new_card_scale)
			var actual_new_card_size = original_card_size * new_card.scale
			print("actual_card_size:", actual_new_card_size)
	#Manage space between cards
			#↓adjust this line for spacing
			var card_spacing = min(actual_new_card_size.x * 0.75, container_x / card_count)
			#↓calculations for positioning
			var total_spacing = (card_count - 1) * card_spacing
			var card_index = new_card.get_index() #Get the index of new card in the node 0->
			if card_index == null:
				push_error("index null")
				return
			var new_card_relative_position = float(card_index)/max(1, card_count -1) #Relative position of the cards in the hand container
			var new_card_x_offset = x_offset_curve.sample(new_card_relative_position) * total_spacing
			new_card.position = Vector2(new_card_x_offset, container_y / 2) #Spawn card with calculated offset & center of container on y axis
			print("Index:",card_index,"🧩 Position:", new_card.position," Global:", new_card.global_position)
			
func draw_card(count:int):
	for i in range(count):
		if player_deck.size() > 0:
			var card_id = player_deck.pop_front()
			player_hand.append(card_id)
			var card = card_default.instantiate()
			hand_node.add_child(card)
			card.create_card(card_id) #This creates the card card u want
			print("Created card with ID: ", card_id)
		print("🃏 Cards in hand: %d" % hand_node.get_child_count())
		update_hand()
