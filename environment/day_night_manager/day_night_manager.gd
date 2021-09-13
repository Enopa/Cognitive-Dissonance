extends CanvasModulate


export var night = bool(false)


func _ready():
	if night == true:
		color = Color(.3, .4, .6, 1)
