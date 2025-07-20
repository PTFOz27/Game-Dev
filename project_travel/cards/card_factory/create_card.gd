extends Node2D

func _ready():
	create_card("102002")
	self.position = Vector2 (400, 400)
	
func create_card(card_id: String) -> void:
	# Get card data from your autoload singleton
	var card = card_database.card_by_id.get(card_id, null)
	if card == null:
		push_error("Card ID %s not found in database" % card_id)
		return
	# print(card)
	# Populate the mana label
	$name.text = str(card["name"])
	$mana.text = str(int(card["mana"]))
	$speed.text = str(card["speed"])
	$type.text = str(card["type"])
	$class.text = str(card["class"])
	$description.bbcode_text = card["description"]
	var art_path = "res://cards/card_resources/card_art/%s art.png/" % card_id
	if ResourceLoader.exists(art_path):
		$card_art.texture = load(art_path)
	else: 
		push_warning("Card art not found for card id %s" % card_id) 
		$card_art.texture = load("res://cards/card_resources/default/default_art.png")
	var frame_path = "res://cards/card_resources/card_art/%s.png/" % card["class"]
	if ResourceLoader.exists(frame_path):
		$frame.texture = load(frame_path)
	else: 
		push_warning("Frame art not found for card class %s" % card["class"]) 
		$frame.texture = load("res://cards/card_resources/default/default_frame.png")
		
func get_card_size():
	if $frame.texture:
		return $frame.texture.get_size() * $frame.scale
	return Vector2.ZERO
	
# Hover System
