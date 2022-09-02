extends HBoxContainer

class_name Guess

onready var GuessResults = preload("res://enum/GuessResults.gd")

onready var red_picker = $Red/LineEdit
onready var green_picker = $Green/LineEdit
onready var blue_picker = $Blue/LineEdit

var guess_made := false setget set_guess_made
func set_guess_made(val):
	guess_made = val
	if !val:
		return
	self.red_picker.editable = false
	self.green_picker.editable = false
	self.blue_picker.editable = false

func get_rgb_vals() -> Array:
	return [
		self.red_picker.value,
		self.green_picker.value,
		self.blue_picker.value
	]

func make_guess():
	self.guess_made = true
	return get_rgb_vals()

func update_guess_results(results: Array):

	var result_icons = [
		$Red/ResultIcon,
		$Green/ResultIcon,
		$Blue/ResultIcon
	]

	for i in results.size():
		result_icons[i].set_icon(results[i])