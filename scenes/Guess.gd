extends HBoxContainer

class_name Guess

onready var red = $Red as ColorGuess
onready var green = $Green as ColorGuess
onready var blue = $Blue as ColorGuess

func make_guess(guess: Dictionary):

	while true:
		if self.red == null || \
			self.green == null || \
			self.blue == null:
			yield(get_tree(), "idle_frame")
			continue
		break

	self.red.update_guess(guess.red)
	self.green.update_guess(guess.green)
	self.blue.update_guess(guess.blue)
