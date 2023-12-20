extends HBoxContainer

var isButtonPressed: bool = false

@onready var button = $Button
@onready var label = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	
	button.connect("pressed", buttonPressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func init(name, keyName):
	label.text = name
	button.text = keyName

# Set buttonPressed to 'true' -> enable 
func buttonPressed():
	isButtonPressed = true


func _input(event: InputEvent):
	# Check event
	if  (event is InputEventKey || event is InputEventMouseButton) && isButtonPressed:
		InputMap.action_erase_events(label.name)
		InputMap.action_add_event(label.name, event)
		
		button.text = event.as_text()
		
		isButtonPressed = false
