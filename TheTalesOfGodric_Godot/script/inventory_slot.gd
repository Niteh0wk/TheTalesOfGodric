extends Control

@onready var item_icon: Sprite2D = $ItemIcon
@onready var item_quantity: Label = $ItemQuantity
@onready var details_panel: ColorRect = $DetailsPanel
@onready var item_name: Label = $DetailsPanel/ItemName
@onready var item_type: Label = $DetailsPanel/ItemType
@onready var item_effect: Label = $DetailsPanel/ItemEffect
@onready var usage_panel: ColorRect = $UsagePanel

var item = null

func _on_item_button_pressed() -> void:
	if item != null:
		usage_panel.visible = !usage_panel.visible

func _on_item_button_mouse_entered() -> void:
	if item != null:
		usage_panel.visible = false
		details_panel.visible = true


func _on_item_button_mouse_exited() -> void:
	details_panel.vibible = false

func set_empty():
	item_icon.texture = null
	item_quantity.text = ""

func set_item(new_item):
	item = new_item
	item_icon = new_item["texture"]
	item_quantity.text = str(item["quantity"])
	item_name.text = str(item["name"])
	item_type.text = str(item["type"])
	if item["effect"] != "":
		item_effect.text = str("+ ", item["effect"])
	else:
		item_effect.text = ""
