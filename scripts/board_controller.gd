extends TileMapLayer

@onready var timer: Timer = $"../Control/FlyCounter/Timer"
const main_atlas_id = 0
enum {NONE=-1, LILYPAD=0, FLY=1}
var cur_building: int = NONE
var building_dict = {
	NONE : Vector2i(2, 0), # water
	LILYPAD : Vector2i(0,0),
	FLY : Vector2i(1,0),
}

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
				set_cell( pos_clicked, main_atlas_id, building_dict[cur_building] )
