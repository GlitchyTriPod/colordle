extends SpinBox

# func _on_LineEdit_focus_entered():
func _ready():
	var le = self.get_line_edit()
	le.text = ""
