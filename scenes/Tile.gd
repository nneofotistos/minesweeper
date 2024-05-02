extends Node2D

var is_cover = true
var is_flagged = false
var is_bomb = false

func set_bomb(): is_bomb = true

func uncover():
	if is_flagged == false:
		if is_bomb == false:
			$AnimatedSprite2D.frame = 1
			is_cover = false
			var count_neighbors = 0
			for tile in get_neighbors():
				if tile.is_bomb:
					count_neighbors += 1
			if count_neighbors > 0:
				$AnimatedSprite2D.frame = count_neighbors + 3
			else:
				for tile in get_neighbors():
					if tile.is_cover:
						tile.uncover()
		else:
			$AnimatedSprite2D.frame = 3

func get_neighbors():
	var neighbors = []
	var offsets = [
		(Vector2.UP + Vector2.LEFT) * 17,
		(Vector2.UP) * 17,
		(Vector2.UP + Vector2.RIGHT) * 17,
		(Vector2.LEFT) * 17,
		(Vector2.RIGHT) * 17,
		(Vector2.DOWN + Vector2.LEFT) * 17,
		(Vector2.DOWN) * 17,
		(Vector2.DOWN + Vector2.RIGHT) * 17
	]
	for offset in offsets:
		for tile in get_parent().tiles:
			if tile.position == position + offset:
				neighbors.append(tile)
	return neighbors

func flag():
	if is_cover:
		if is_flagged:
			is_flagged = false
			$AnimatedSprite2D.frame = 0
		else:
			is_flagged = true
			$AnimatedSprite2D.frame = 2

func _on_control_gui_input(event):
	if event.is_action_pressed("left_click"):
		uncover()
	if event.is_action_pressed("right_click"):
		flag()
	if event.is_action_pressed("middle_click"):
		print("middle!")
