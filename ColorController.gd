extends Node

class_name ColorController

onready var color_swatch = get_parent().get_node("Control/Swatches/ColorSwatch")

onready var latest_guess = self.color_swatch.get_node("LatestGuess")

onready var guess_swatches := get_parent().get_node("Control/Swatches/Guesses").get_children()

var target_red := 0.0
var target_green := 0.0
var target_blue := 0.0

func _ready():
	update_color()	

# selects a new color (resets the game)
func update_color():
	randomize()
	self.target_red = rand_range(0,1)
	randomize()
	self.target_green = rand_range(0,1)
	randomize()
	self.target_blue = rand_range(0,1)

	self.color_swatch.color = Color(self.target_red, self.target_green, self.target_blue)

	for swatch in self.guess_swatches:
		swatch.color = Color("#00808080")
	self.latest_guess.self_modulate = Color("#00ffffff")

	if OS.has_feature("debug"):
		var tmp_str = "Color set to [ R: %s G: %s B: %s ]"

		var colors = get_color_info_as_int()

		print(tmp_str % [ str(colors[0]), str(colors[1]), str(colors[2])])

func get_color_info_as_int():
	return [
		int(round(256.0 * self.target_red)),
		int(round(256.0 * self.target_green)),
		int(round(256.0 * self.target_blue)),
	]

func add_guess_color(clr: Color):
	self.latest_guess.self_modulate = clr
	for swatch in self.guess_swatches:
		if swatch.color == Color("#00808080"):
			var twn: SceneTreeTween = get_tree().create_tween()
			return twn.tween_property(
				swatch,
				"color",
				clr,
				0.3
			)
