extends Node2D
 
var dialogPath = ""
var textSpeed = 0.02
 
var dialog
@onready var timer = get_node("Timer")
@onready var Text = get_node("Texte")

var phraseNum = 0
var finished = false
 
func _ready():
	timer.wait_time = textSpeed
	PrintSentence("Bienvenue dans le Monde Creux! Vous devez trouver l'Azalea!")
 
func _process(_delta):
	pass
 

func PrintSentence(text):
	Text.visible_characters = 0
	Text.text = text
	while Text.visible_characters < len(Text.text):
		Text.visible_characters += 1
		timer.start()
		await timer.timeout
	finished = true
	phraseNum += 1
