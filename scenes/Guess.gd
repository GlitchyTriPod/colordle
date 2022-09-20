extends HBoxContainer

class_name Guess

onready var red = $Red as ColorGuess
onready var green = $Green as ColorGuess
onready var blue = $Blue as ColorGuess

onready var tween = $Tween

func _ready():
	self.modulate = Color("#00ffffff")

func make_guess(guess: Dictionary):

	self.red.update_guess(guess.red)
	self.green.update_guess(guess.green)
	self.blue.update_guess(guess.blue)

	self.tween.interpolate_property(
		self,
		"modulate",
		self.modulate,
		Color("#ffffff"),
		0.3
	)
	self.tween.interpolate_property(
		self,
		"rect_position",
		Vector2(self.rect_position.x, self.rect_position.y + 50),
		self.rect_position,
		0.3,
		Tween.EASE_OUT
	)
	self.tween.start()