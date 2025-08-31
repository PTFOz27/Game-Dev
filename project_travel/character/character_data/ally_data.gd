extends Node
class_name CharacterData

var allies: Dictionary = {
	"001": {
		"name": "Aurelia",
		"base_hp": 100,
		"current_hp": 80,
		"attack": 25,
		"resistance": 0.1,
		"dodge": 0.1,
		"critical_chance": 0.2,
		"quirks": ["Brave", "Curious"]
	},
	"002": {
		"name": "Thomas",
		"base_hp": 120,
		"current_hp": 120,
		"attack": 30,
		"resistance": 0.2,
		"dodge": 0.5,
		"critical_chance": 0.3,
		"quirks": ["Strong", "Loyal"]
	},
	"003": {
		"name": "Luna",
		"base_hp": 80,
		"current_hp": 65,
		"attack": 20,
		"resistance": 0.1,
		"dodge": 0.1,
		"critical_chance": 0.5,
		"quirks": ["Smart", "Quick"]
	},
	"004": {
		"name": "Magnus",
		"base_hp": 150,
		"current_hp": 150,
		"attack": 35,
		"resistance": 0.25,
		"dodge": 0.2,
		"critical_chance": 0.2,
		"quirks": ["Tough", "Stubborn"]
	}
}

# Helper function to get ally by ID

# Get ally stats summary
func get_ally_stats(id: String) -> Dictionary:
	var data = allies.get(id, {})
	if not allies.has(id):
		push_error("Ally ID not found: " + id)
	return allies[id]

# Update ally HP
func update_ally_hp(ally_id: String, new_hp: int) -> void:
	if allies.has(ally_id):
		allies[ally_id]["current_hp"] = max(0, min(new_hp, allies[ally_id]["base_hp"]))

# Get top allies by stat
func get_top_allies_by_stat(stat: String, limit: int = 3) -> Array:
	var sorted_allies = allies.keys()
	sorted_allies.sort_custom(func(a, b): return allies[a].get(stat, 0) > allies[b].get(stat, 0))
	return sorted_allies.slice(0, min(limit, sorted_allies.size()))

# Get all allies with current status
