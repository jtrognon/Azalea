extends Node2D

const json_class_sheet_path = "res://Json/Class_sheet.json"

var character_class
var health
var max_health = 0
var defense
var wisdom
var strenght
var dices = {}
var intelligence
var power
var dexterity
var charisma

func set_class(character_class_):
	character_class = character_class_
	
func init_player():
	var json_file = FileAccess.open(json_class_sheet_path,FileAccess.READ)
	var dict = JSON.parse_string(json_file.get_as_text())
	health = dict[character_class]["health"]
	max_health += health
	defense = dict[character_class]["defense"]
	wisdom = dict[character_class]["wisdom"]
	intelligence = dict[character_class]["intelligence"]
	power = dict[character_class]["power"]
	dexterity = dict[character_class]["dexterity"]
	charisma = dict[character_class]["charisma"]
	strenght = dict[character_class]["strenght"]
	dices = dict[character_class]["dices"]

func get_dices():
	return dices
	
func inflict_damage(damage):
	var damage_taken = max (0 , damage - defense)
	health -= damage_taken
	return damage_taken

func get_player_stats():
	var stats_dict = {}
	stats_dict["wisdom"] = wisdom
	stats_dict["strenght"] = strenght
	stats_dict["intelligence"] = intelligence
	stats_dict["power"] = power
	stats_dict["dexterity"] = dexterity
	stats_dict["charisma"] = charisma
	return stats_dict
