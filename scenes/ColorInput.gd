extends LineEdit

class_name ColorInput

func _ready():
	var _ignore = self.connect("focus_exited", self, "_on_focus_exited")
	_ignore = self.connect("focus_entered", self, "_on_focus_exited")
	return self.connect("text_changed", self, "_validate_text")

func _validate_text(new_text: String) -> void:
	var regex = RegEx.new()
	regex.compile("[^0-9]")
	var result = regex.search(new_text)
	var cached_caret_pos = self.caret_position
	if result:
		self.text = regex.sub(self.text, "", true)
		caret_position = cached_caret_pos - 1

	# check for leading zeros
	result = null
	regex.compile("^0")
	result = regex.search(self.text)
	if result:
		self.text = regex.sub(self.text, "")

func _on_focus_exited():
	if int(self.text) > 256:
		self.text = "256"
	elif self.text == "":
		self.text = "0"

func _on_focus_entered():
	if self.text == "0":
		self.text = ""