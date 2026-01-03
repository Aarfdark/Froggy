extends TileMapLayer

const main_atlas_id = 0

enum {NONE=-1, LILYPAD=0, FLY=1}
var cur_building: int = NONE
var building_dict = {
	NONE : Vector2i(2, 0), # water
	LILYPAD : Vector2i(0,0),
	FLY : Vector2i(1,0),
}
var building_counter = {
	NONE: 0,
	LILYPAD: 0,
	FLY: 0,
}

# fly stuff
@onready var fly_counter: Label = $"../Control/ResourceUI/VBoxContainer/FlyCounter"
var num_flies: int
var building_cost = {
	NONE : 0,
	LILYPAD: 100,
	FLY: 200,
}
var fly_income: int

# frog stuff
@onready var frog_counter: Label = $"../Control/ResourceUI/VBoxContainer/FrogCounter"
var frog_capacity: int

func set_building(type):
	cur_building = type

func check_neighbors(lame_pos: Vector2i):
	# https://www.reddit.com/r/godot/comments/tsk8fb/hexagonal_tilemap_finding_neighbours_problem/
	var pos = Vector2i( lame_pos.x - (lame_pos.y-abs(lame_pos.y) % 2) / 2, lame_pos.y )
	
	var left = Vector2i(pos.x-1, pos.y)
	var right = Vector2i(pos.x+1, pos.y)
	var upleft = Vector2i(pos.x-1, pos.y-1)
	var upright = Vector2i(pos.x,pos.y-1)
	var downleft = Vector2i(pos.x-1, pos.y+1)
	var downright = Vector2i(pos.x,pos.y+1)

func _input(event):
	if event is InputEventMouseButton:
		var global_clicked = event.position
		var pos_clicked = local_to_map(to_local(global_clicked))
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			var cur_tile_alt = get_cell_alternative_tile(pos_clicked)
			# there is a tile where the mouse was clicked
			if cur_tile_alt != -1:
				print(pos_clicked)
				# checks the number of flies currently
				if num_flies >= building_cost[cur_building]:
					set_cell( pos_clicked, main_atlas_id, building_dict[cur_building] )
					num_flies -= building_cost[cur_building]
				else:
					print("Not enough flies to build " + str(cur_building))
		elif event.button_index == MOUSE_BUTTON_MIDDLE and event.is_pressed():
			check_neighbors(pos_clicked)

func _process(_delta):
	fly_counter.text = "🪰: " + str(num_flies)

func _on_timer_timeout() -> void:
	num_flies += 25
