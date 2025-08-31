extends Node2D



func _ready():
	hand_manager.hand_node = $hand_container/hand
	hand_manager.player_deck = ["101001", "101002", "102001", "102001", "102002", "101001", "101002", "102001", "102001", "101001", "101002", "102001", "102001", "101001", "101002", "102001", "102001", "101001", "101002", "102001", "102001", "101001", "101002", "102001", "102001", "101001", "101002", "102001", "102001", "101001", "101002", "102001", "102001", "101001", "101002", "102001", "102001", ]
	hand_manager.player_hand = []
	hand_manager.update_hand()
	load_ally("001",-1)
	load_ally("002",-2)
func button_draw_card() -> void:
	card_functions.draw_card(1)
func button_play_card() -> void:
	card_functions.play_card("101001")
func load_ally(ally_id:String, start_pos: int = 0):
	var ally_scene: PackedScene = preload("res://character/default_character.tscn")
	var ally_instance: Node2D = ally_scene.instantiate()
	ally_instance.ally_id = ally_id
	var ally_containers := [
	$ally_container/ally_container1,
	$ally_container/ally_container2,
	$ally_container/ally_container3, 
	$ally_container/ally_container4] #This sets the location of where to load the character
	#start_pos =  character_instance.combat_position
	var container_index = -start_pos - 1 #this compensates the values for Arrays (0 -> 3) into ones we use (-1 -> -4)
	ally_containers[container_index].add_child(ally_instance)
	return ally_instance


func _on_deselect_button_pressed() -> void:
	card_functions.deselect()


func _on_damage_button_pressed() -> void:
	card_functions.deal_damage(20)
