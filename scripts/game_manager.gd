# kills you badstyle
extends Node2D

@onready var building_container: HBoxContainer = $Control/BuildingUI/MarginContainer/BuildingContainer
@onready var board_controller: TileMapLayer = $Board

enum {NONE=-1, LILYPAD=0, FLY=1}
var building_buttons: Array

var num_flies = 0
@onready var fly_counter: Label = $Control/FlyCounter

func _ready():
	building_buttons = building_container.get_children()
	for button in building_buttons:
		button.connect("toggled", building_select.bind(button))
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.is_pressed():
			for button in building_buttons:
				button.button_pressed = false

func building_select(toggled, cur_button):
	# if a button is selected, deselect all the others
	if toggled:
		for button in building_buttons:
			if button != cur_button:
				button.button_pressed = false
		# send the selected building type to the board_controller
		match cur_button.text:
			"Lilypad": board_controller.set_building(LILYPAD)
			"Fly": board_controller.set_building(FLY)
	if !toggled:
		board_controller.set_building(NONE)
