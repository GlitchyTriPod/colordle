extends Node

class_name InputController

var current_input: LineEdit setget , get_current_input
func get_current_input():
	return get_node("/root/Main").get_focus_owner()

var current

func _on_number_selected(number_val: int):

	if self.current_input == null:
		return

	if number_val == -1:
		var curr_text = self.current_input.text
		curr_text.erase(
			curr_text.length() - 1, 1
		)
		self.current_input.text = curr_text
	elif number_val == -2:
		self.current_input.text = ""
	else:
		self.current_input.text += str(number_val)

