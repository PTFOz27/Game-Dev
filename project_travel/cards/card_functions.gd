extends Node

func play_card(card_id: String):
	#'card' is the data of the card
	#'card_instance' refers the instance of card generated
	var card = card_database.card_by_id.get(card_id, null)
	if card == null:
		push_error("Card_data not found: %s" % card_id)
		return
	
	var play_position = card["position"]["playable"]
	#Need to place the combat scene and put placeholder allys in place
	
	var target_info = card["position"]["target"]
	var options = target_info["options"]
	var mode = target_info["mode"]
	var mode_type = mode[0]
	var mode_value = mode[1]

	
	
	
	

	#var targets = resolve_targets(target_info["options"], target_info["mode"])
	#print("Targets chosen for %s: %s" % [card["name"], targets])
	
	
	
	
	
	
	
	var script_path = "res://cards/card_properties/card_scripts/%s.gd" % card_id
	var script = load(script_path)
	if script == null:
		push_error("❌ Failed to load script for card ID %s" % card_id)
		return
	var card_instance = script.new()
	if card_instance.has_method("play"):
		card_instance.play()
		print("played the card:", card["name"])
	else:
		push_error("⚠️ Script %s has no 'play()' method" % script_path)
		
func resolve_targets(options: Array, mode: Array) -> Array:
	var mode_type = mode[0]
	var mode_value = mode[1]
	var final_targets = []

	match mode_type:
		"random":
			var shuffled = options.duplicate()
			shuffled.shuffle()
			final_targets = shuffled.slice(0, mode_value)
		"select":
			# For now, simulate player choice (later you’d show a UI to pick)
			final_targets = options.slice(0, mode_value)
		"exact":
			# Exact could mean: choose option at index or with a matching ID
			if mode_value > 0 and mode_value <= options.size():
				final_targets = [options[mode_value - 1]]
		"all":
			final_targets = options

	return final_targets

func draw_card(count:int):
	hand_manager.draw_card(count)
