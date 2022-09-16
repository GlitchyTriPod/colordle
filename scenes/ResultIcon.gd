extends Node2D

class_name ResultIcon

onready var GuessResults = preload("res://enum/GuessResults.gd")

onready var label = $Label
onready var texture = $TextureRect

func _ready():
	self.visible = false

func set_icon(result):
	match result:
		GuessResults.GUESS_RESULTS.PERFECT:
			self.label.text = "perfect!"
			self.texture.modulate = Color("#fff967")
		GuessResults.GUESS_RESULTS.CLOSE:
			self.label.text = "close!"
			self.texture.modulate = Color("#ffa34a")
		GuessResults.GUESS_RESULTS.HOT:
			self.label.text = "hot"
			self.texture.modulate = Color("#ec2929")
		GuessResults.GUESS_RESULTS.WARM:
			self.label.text = "warm"
			self.texture.modulate = Color("#b8ec29")
		GuessResults.GUESS_RESULTS.COOL:
			self.label.text = "cool"
			self.texture.modulate = Color("#29ec9a")
		GuessResults.GUESS_RESULTS.COLD:
			self.label.text = "cold"
			self.texture.modulate = Color("#2995ec")

	self.visible = true