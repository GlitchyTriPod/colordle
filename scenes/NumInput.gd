extends Button

class_name NumInput

signal number_selected(number_val)

export var value := 0

func _ready():
	return self.connect("button_up", self, "_on_button_up")

func _on_button_up():
	emit_signal("number_selected", self.value)