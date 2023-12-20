extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	var actionsList = []
	var actionDict = {}
	for input in InputMap.get_actions():
		if !input.begins_with("ui"):
			print(input)
			actionsList.append(input)
			
	var keyBindingPrefab = preload("res://Prefabs/keybindingPrefab.tscn")
	for action in actionsList:
		var actionButton = keyBindingPrefab.instantiate()
		
		var eventKey: String
		if InputMap.action_get_events(action) != []:
			eventKey = InputMap.action_get_events(action)[0].as_text()
		else:
			eventKey = ""
			
		actionDict[action] = [actionButton, eventKey]
		$VBoxContainer.add_child(actionButton)
		
	updateAll(actionDict)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func updateAll(actionDict):
	for action in actionDict.keys():
		var widget = actionDict[action][0]
		var eventKey = actionDict[action][1]
		
		widget.init(action, eventKey)
