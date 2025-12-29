extends TileMapLayer

const main_atlas_id = 0

enum {NONE=-1, LILYPAD=0, FLY=1}
var cur_building: int = NONE
var building_dict = {
	NONE : Vector2i(2, 0), # water
	LILYPAD : Vector2i(0,0),
	FLY : Vector2i(1,0),
}

@onready var fly_counter: Label = $"../Control/ResourceUI/FlyCounter"
var num_flies: int
var building_cost = {
	NONE : 0,
	LILYPAD: 100,
	FLY: 200,
}

@onready var frog_counter: Label = $"../Control/ResourceUI/FrogCounter"

func set_building(type):
	cur_building = type

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			var global_clicked = event.position
			var pos_clicked = local_to_map(to_local(global_clicked))
			var cur_tile_alt = get_cell_alternative_tile(pos_clicked)
			# there is a tile where the mouse was clicked
			if cur_tile_alt != -1:
				# checks the number of flies currently
				if num_flies >= building_cost[cur_building]:
					set_cell( pos_clicked, main_atlas_id, building_dict[cur_building] )
					num_flies -= building_cost[cur_building]
				else:
					print("Not enough flies to build " + str(cur_building))

func _process(_delta):
	fly_counter.text = "🪰: " + str(num_flies)

func _on_timer_timeout() -> void:
	num_flies += 25
