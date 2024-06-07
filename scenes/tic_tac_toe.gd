extends Node2D

var turn = 1 #0 for O, 1 for X
var mouse_pos

func _input(event):
	mouse_pos = $TileMap.world_to_map(get_global_mouse_position())
	
	if event is InputEventMouseMotion:
		$TileMap_hover.clear()
		$TileMap_hover.set_cell(mouse_pos.x, mouse_pos.y, turn)
	
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.is_pressed():
			if $TileMap.get_cell(mouse_pos.x, mouse_pos.y) == -1:
				$TileMap.set_cell(mouse_pos.x, mouse_pos.y, turn)
				if turn == 1:
					turn = 0
				else:
						turn = 1
				_check_board()


func _check_board():
	#horizontal
	for i in range(3):
		if (
			$TileMap.get_cell(0, i) != -1 and
			$TileMap.get_cell(0, i) == $TileMap.get_cell(1, i) and
			$TileMap.get_cell(0, i) == $TileMap.get_cell(2, i)
		):
			_winner($TileMap.get_cell(0, i))
			return
	#vertical
	for i in range(3):
		if (
			$TileMap.get_cell(i, 0) != -1 and
			$TileMap.get_cell(i, 0) == $TileMap.get_cell(i, 1) and
			$TileMap.get_cell(i, 0) == $TileMap.get_cell(i, 2)
		):
			_winner($TileMap.get_cell(i, 0))
			return
	#diagonal
	if (
		$TileMap.get_cell(0, 0) != -1 and
		$TileMap.get_cell(0, 0) == $TileMap.get_cell(1, 1) and
		$TileMap.get_cell(0, 0) == $TileMap.get_cell(2, 2)
	):
		_winner($TileMap.get_cell(0, 0))
		return
	if (
		$TileMap.get_cell(2, 0) != -1 and
		$TileMap.get_cell(2, 0) == $TileMap.get_cell(1, 1) and
		$TileMap.get_cell(2, 0) == $TileMap.get_cell(0, 2)
	):
		_winner($TileMap.get_cell(2, 0))
		return
	#tie
	if $TileMap.get_used_cells().size() == 9:
		_winner(-1)
		return

func _winner(winner):
	if winner == 0:
		print("O win")
	elif winner ==1:
		print("X win")
	else:
		print("tie")
	get_tree().reload_current_scene()
