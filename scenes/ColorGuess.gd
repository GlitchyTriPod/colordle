extends Label

class_name ColorGuess

export(int, "Red", "Green", "Blue") var color

onready var arrow = $AnimatedSprite
onready var result_icon = $ResultIcon

var answer_color_val: int

func _ready():
	var color_controller = get_node("/root/Main/ColorController")
	self.answer_color_val = color_controller.get_color_info_as_int()[self.color]

func update_guess(guess: Dictionary):
	self.text = str(guess.value)

	if guess.value < self.answer_color_val:
		self.arrow.frame = 0
	elif guess.value > self.answer_color_val:
		self.arrow.frame = 1
	else:
		self.arrow.frame = 2
		
	self.result_icon.set_icon(guess.result)