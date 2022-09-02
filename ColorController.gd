extends Node

class_name ColorController

onready var color_swatch = get_parent().get_node("Control/ColorSwatch")

var target_red := 0.0
var target_green := 0.0
var target_blue := 0.0

func _ready():
	update_color()	

func update_color():
	randomize()
	self.target_red = rand_range(0,1)
	randomize()
	self.target_green = rand_range(0,1)
	randomize()
	self.target_blue = rand_range(0,1)

	self.color_swatch.color = Color(self.target_red, self.target_green, self.target_blue)

func get_color_info_as_int():
	return [
		int(round(256.0 * self.target_red)),
		int(round(256.0 * self.target_green)),
		int(round(256.0 * self.target_blue)),
	]

	