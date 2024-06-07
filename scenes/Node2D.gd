extends Control

func _ready():
	# Tambahkan event listener untuk tombol Mulai
	$StartButton.connect("pressed", self, "_on_start_button_pressed")

func _on_start_button_pressed():
	# Pindahkan scene ke permainan
	get_tree().change_scene("res://GameScene.tscn")
