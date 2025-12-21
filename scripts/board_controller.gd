extends TileMapLayer

const main_atlas_id = 0

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			var global_clicked = event.position
			var pos_clicked = local_to_map(to_local(global_clicked))
			var cur_atlas_coords = get_cell_atlas_coords(pos_clicked)
			var cur_tile_alt = get_cell_alternative_tile(pos_clicked)
			var total_num_alts = tile_set.get_source(main_atlas_id).get_alternative_tiles_count(cur_atlas_coords)
			set_cell(pos_clicked, main_atlas_id, cur_atlas_coords, (cur_tile_alt+1)%total_num_alts )
