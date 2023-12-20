extends Node2D

const usable_stats_const = ["strenght","wisdom","intelligence","power","dexterity","charisma"]
const usable_logical_operators = ["OR","OR","OR","OR","OR","AND","AND","AND","AND","AND","AND","AND","XOR","XOR","XOR","NOR","NAND"]
const starting_level_limit = [3,7]
var random = RandomNumberGenerator.new()

@onready var m = get_node("DialogBox")
# Called when the node enters the scene tree for the first time.
func _ready():
	#preload("res://Scripts/DialogBox.gd")
	#Player.set_class("warrior")
	#Player.init_player()
	#var challenge = generate_challenge(7)
	#print(challenge)
	#var arbitrary_player_stats = Player.get_player_stats()
	#print(is_challenge_complete(arbitrary_player_stats,challenge))
	#if is_challenge_complete(arbitrary_player_stats,challenge):
		#m.Text.text = "Congratulations! You defeated the Ennemy!"
	#else:
		#m.Text.text = "Looser !"
	#m.PrintSentence()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func generate_challenge(world_level):
	var usable_stats = []+usable_stats_const
	var used_stats = []
	var selected_stat_index
	var selected_operator_index
	var iterations_number = min(random.randi_range(1,world_level),len(usable_stats_const))
	var operators = []
	var number
	var stat_dict = {}
	for i in range (iterations_number):
		selected_stat_index = random.randi_range(0,len(usable_stats)-1)
		used_stats += [usable_stats[selected_stat_index]]
		usable_stats.remove_at(selected_stat_index)
	for stat in used_stats:
		number = roundi(0.5*exp(world_level*(0.5+random.randf_range(-0.05,0.05)))+random.randi_range(starting_level_limit[0],starting_level_limit[1]))
		stat_dict[stat] = number
	for i in range (iterations_number-1):
		selected_operator_index = random.randi_range(0,len(usable_logical_operators)-1)
		operators+=[usable_logical_operators[selected_operator_index]]
	return {"stats_dict":stat_dict,"stats":used_stats,"operators":operators}

func is_challenge_complete(player_stats,dict_challenge):
	#NE FONCTIONNE PAS ! A CORRIGER ! Remplacer le number0 avec la variable booléenne d'avant !
	var number0
	var number1
	var number0key
	var number1key
	number0key = dict_challenge["stats"][0]
	number0 = dict_challenge["stats_dict"][number0key]
	var is_it_complete = player_stats[number0key] > number0
	for i in range(1,len(dict_challenge["stats"])):
		number1key = dict_challenge["stats"][i]
		number1 = dict_challenge["stats_dict"][number1key]
		if dict_challenge["operators"][i-1]=="AND":
			is_it_complete = is_it_complete and (player_stats[number1key] > number1)
		elif dict_challenge["operators"][i-1]=="OR":
			is_it_complete = is_it_complete or (player_stats[number1key] > number1)
		elif dict_challenge["operators"][i-1]=="XOR":
			is_it_complete = is_it_complete != (player_stats[number1key] > number1)
		elif dict_challenge["operators"][i-1]=="NOR":
			is_it_complete = not(is_it_complete or (player_stats[number1key] > number1))
		else:
			is_it_complete = not(is_it_complete or (player_stats[number1key] > number1))
	return is_it_complete


func roll_all_dices():
	var dic_rolled_dices = {}
	for key in Player.dices:
		for key2 in Player.dices[key]:
			for i in range (Player.dices[key][key2]):
				if key not in dic_rolled_dices:
					dic_rolled_dices[key] = [dice_roll(int(key2))]
				else:
					dic_rolled_dices[key] += [dice_roll(int(key2))]
	return dic_rolled_dices

func dice_roll(faces_nb):
	return random.randi_range(1,faces_nb)
