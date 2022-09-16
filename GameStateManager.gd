extends Node

class_name GameStateManager


onready var Guess = preload("res://scenes/Guess.tscn")
onready var GuessResults = preload("res://enum/GuessResults.gd")

onready var guess_holder = get_parent().get_node("Control/Guesses")
onready var color_controller = get_parent().get_node("ColorController")

onready var answer_lbl = get_parent().get_node("Control/Answer")
onready var win_msg = get_parent().get_node("Control/WinMsg")

onready var input_red = get_parent().get_node("Control/ColorInput/Red")
onready var input_green = get_parent().get_node("Control/ColorInput/Green")
onready var input_blue = get_parent().get_node("Control/ColorInput/Blue")

onready var guess_btn = get_parent().get_node("Control/Inputs/Row3/Guess")

var guess_count := 0 setget set_guess_count
func set_guess_count(val):
	guess_count = val
	if val == 6:
		display_answer()
		self.guess_btn.text = "Play Again?"

func _ready():
	for gues in self.guess_holder.get_children():
		gues.queue_free()

func add_new_guess(guess_data: Dictionary):
	if guess_count > 6:
		return
		
	var guess = Guess.instance()

	guess_holder.add_child(guess)

	yield(get_tree(), "idle_frame")
	
	guess.make_guess(guess_data)

func check_guess():
	# find guess that has not been submitted, get guess information
	var guess_vals = [
		int(self.input_red.text),
		int(self.input_green.text),
		int(self.input_blue.text)
	]

	var color_vals = self.color_controller.get_color_info_as_int()

	var guess_results = []
	for i in color_vals.size():
		guess_results.push_back(
			compare_values(color_vals[i], guess_vals[i])
		)

	var guess_data = {
		"red": {
			"value": guess_vals[0],
			"result": guess_results[0]
		},
		"green": {
			"value": guess_vals[1],
			"result": guess_results[1]
		},
		"blue": {
			"value": guess_vals[2],
			"result": guess_results[2]
		},
	}

	# call color controller to add guess colors to swatches
	var int_color = Color()
	int_color.r8 = guess_vals[0]
	int_color.g8 = guess_vals[1]
	int_color.b8 = guess_vals[2]
	self.color_controller.add_guess_color(int_color)

	if guess_results.has(GuessResults.GUESS_RESULTS.COLD) || \
	 guess_results.has(GuessResults.GUESS_RESULTS.COOL) || \
	 guess_results.has(GuessResults.GUESS_RESULTS.WARM) || \
	 guess_results.has(GuessResults.GUESS_RESULTS.HOT):
		pass
	elif !guess_results.has(GuessResults.GUESS_RESULTS.CLOSE):
		self.win_msg.text = "Perfect win!"
		self.guess_count = 6
		return
	else:
		self.win_msg.text = "You win! Go for a Perfect!"

	add_new_guess(guess_data)

func compare_values(target_val, guess_val):
	var diff = abs(target_val - guess_val)

	if diff == 0:
		return GuessResults.GUESS_RESULTS.PERFECT
	elif diff <= 10:
		return GuessResults.GUESS_RESULTS.CLOSE
	elif diff <= 32:
		return GuessResults.GUESS_RESULTS.HOT
	elif diff <= 64:
		return GuessResults.GUESS_RESULTS.WARM
	elif diff <= 128:
		return GuessResults.GUESS_RESULTS.COOL
	else:
		return GuessResults.GUESS_RESULTS.COLD

func display_answer():
	var colors = self.color_controller.get_color_info_as_int()

	var ans = "R:%s G:%s B:%s"

	ans = ans % [ str(colors[0]), str(colors[1]), str(colors[2])]

	self.answer_lbl.text = ans

func reset_game():
	self.guess_count = 0
	self.color_controller.update_color()
	self.guess_btn.text = "Guess!"
	self.win_msg.text = ""
	self.answer_lbl.text = ""

	var guesses = self.guess_holder.get_children()

	for i in guesses.size():
		guesses[i].queue_free()

	# add_new_guess()

# make guess
func _on_Button_button_up():
	if self.guess_count >= 6:
		reset_game()
		return

	self.guess_count += 1

	check_guess()
