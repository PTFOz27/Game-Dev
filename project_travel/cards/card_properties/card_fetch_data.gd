extends Node2D
var card_data := {} # public variable
var card_by_id := {}
func _ready() -> void:
#1. Getting Files
	var file := FileAccess.open("res://cards/card_properties/card_index.json", FileAccess.READ)
	if not file:
		push_error("❌ Failed to open file.")
		return
#2. Parsing JSON into dictionatry
	var json_text := file.get_as_text()
	var json := JSON.new()
	var parse_result := json.parse(json_text)

	if parse_result != OK:
		push_error("❌ JSON parse error: %s" % json.get_error_message())
		return
	card_data = json.get_data()
	print("✅ Parsed JSON:")
	# print(card_data)
#3. Validating card_data to be types we want e.g. string, int etc.
	if validate_card_data():
		print("✅ Valid JSON data types")
	else:
		push_error("❌ Invalid card data types")
#4. Accessing the whole card_data through id only.
	for card_class in card_data: # card_class will be top level array in json file (see card_index.json)
		# print("Card class:", card_class)
		for card in card_data[card_class]: # loop2 begins
			var card_id = card["id"]
			# print("Storing card ID:", card_id)
			if card_id in card_by_id:
				push_error("⚠️ Duplicate card id found: %s" % card_id)
			card_by_id[card_id] = card # loop2 ends
# Debugging codes
	#if "101001" in card_by_id: print("✅ 101001 exists:", card_by_id["101001"]["mana"]) 
	#else: push_error("❌ 101001 not found")
	#if "101002" in card_by_id: print("✅ 101002 exists:", card_by_id["101002"]["mana"])
	# else: push_error("❌ 101002 not found")
	
# Now access any card properties through:
# card_by_id[id][property_name]
pass
func validate_card_data() -> bool: # Validate top-level structure
	if card_data.is_empty():
		push_error("Data is empty")
		return false
		
	for card_type in card_data:
		# Validate card type key (letters only)
		if not card_type.is_valid_identifier() or card_type.to_lower() != card_type:
			push_error("Invalid card type key: %s (must be lowercase letters only)" % card_type)
			return false
		# Validate card array
		var cards = card_data[card_type]
		if not cards is Array:
			push_error("Card type %s value is not an array" % card_type)
			return false
		
		for card in cards:
			if not validate_card_properties(card):
				push_error("Invalid card properties")
				return false
	return true
func validate_card_properties(card: Dictionary) -> bool: # Validate each fields
	var required_fields = ["id", "name", "mana", "type", "speed", "description", "position"]
	for field in required_fields:
		if not field in card:
			push_error("Missing required field: %s" % field)
			return false

	# Validate field types
	if not card["id"] is String:
		push_error("Card ID must be an string")
		print(typeof(card["id"]))
		return false
	
	if not card["name"] is String:
		push_error("Card name must be a string")
		return false
	
	if not int(card["mana"]) == card["mana"] or card["mana"] < 0:
		push_error("Card mana must be a non-negative integer")
		return false
	
	if not card["type"] is String:
		push_error("Card type must be a string")
		return false
	
	var valid_speeds = ["Normal", "Burst", "Slow"]
	if card["speed"] not in valid_speeds:
		push_error("Invalid speed value: %s (must be one of: %s)" % [card["speed"], valid_speeds])
		return false
	
	if not card["description"] is String:
		push_error("Card description must be a string")
		return false

	# Validate position and target
	var position_data = card["position"]
	if not "playable" in position_data or not "target" in position_data:
		push_error("Position missing required fields (playable or target)")
		return false

	# Validate playable: still must be Array of ints from -4 to -1 or 1 to 4
	if not position_data["playable"] is Array:
		push_error("Position playable must be an array")
		return false

	for item in position_data["playable"]:
		if not item is String:
			push_error("Position playable must contain strings")
			return false
		if int(item) > -1 or int(item) < -4:
			push_error("Position playable strings must represent integers between -4 and -1")
			return false

	# Validate target: expect a Dictionary with "options" and "mode"
	if not position_data["target"] is Dictionary:
		push_error("Position target must be a dictionary with 'options' and 'mode'")
		return false
	if not position_data["target"].has("options") or not position_data["target"].has("mode"):
		push_error("Position target dictionary must have 'options' and 'mode' keys")
		return false

	# Validate options: array of strings
	if not position_data["target"]["options"] is Array:
		push_error("Position target 'options' must be an array")
		return false

	for opt in position_data["target"]["options"]:
		if not opt is String:
			push_error("Position target option must be a string")
			return false

# Mode must be an array of exactly 2 elements
	var mode = position_data["target"]["mode"]
	if not mode is Array or mode.size() != 2:
		push_error("Target mode must be an array of exactly 2 elements: [type, value]")
		return false
# Validate mode type
	var mode_type = mode[0]
	var valid_modes = ["select", "exact", "random", "all"]
	if not mode_type is String or mode_type not in valid_modes:
		push_error("Invalid mode type: %s (must be one of: %s)" % [mode_type, valid_modes])
		return false
# Validate mode value depending on type
	var mode_value = mode[1]
	match mode_type:
		"select", "exact", "random":
			if not int(mode_value) == mode_value or int(mode_value) < 1:
				push_error("Mode '%s' must have a positive integer value" % mode_type)
				return false
		"all":
			if mode_value != null:
				push_error("Mode 'all' must use null as value")
				return false
	# Optional field validation
	if "comment" in card and not card["comment"] is String:
		push_error("Card comment must be a string if present")
		return false
	return true
