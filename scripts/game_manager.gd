# kills you badstyle
extends Node2D

@onready var building_container: HBoxContainer = $Control/BuildingUI/MarginContainer/BuildingContainer
var building_buttons

func _ready():
	building_buttons = building_container.get_children()
	for button in building_buttons:
		button.connect("toggled", building_select.bind(button))
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.is_pressed():
			for button in building_buttons:
				pass
	
func building_select(toggled, cur_button):
	# if a button is selected, deselect all the others
	if toggled:
		for button in building_buttons:
			if button != cur_button:
				button.disabled = true
	# make everything selectable after ticking it off
	if !toggled:
		for button in building_buttons:
			if button != cur_button:
				button.disabled = false
