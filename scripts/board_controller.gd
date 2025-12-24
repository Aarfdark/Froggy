extends TileMapLayer

const main_atlas_id = 0
enum {NONE=-1, LILYPAD=0, FLY=1}
var cur_building: int

func set_building(type):
	cur_building = type
	print(type)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			var global_clicked = event.position
			var pos_clicked = local_to_map(to_local(global_clicked))
			var cur_atlas_coords = get_cell_atlas_coords(pos_clicked)
			var cur_tile_alt = get_cell_alternative_tile(pos_clicked)
			# there is a tile where the mouse was clicked
			if cur_tile_alt != -1:
				var total_num_alts = tile_set.get_source(main_atlas_id).get_alternative_tiles_count(cur_atlas_coords)
				set_cell(pos_clicked, main_atlas_id, cur_atlas_coords, (cur_tile_alt+1)%total_num_alts )
