@tool
extends Node2D


@export var item_type : String
@export var item_name : String
@export var item_texture : Texture
var scene_path : String = "res://scenes/inventory_item.tscn"

@onready var icon_sprite: Sprite2D = $Icon_Sprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not Engine.is_editor_hint():
		icon_sprite.texture = item_texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		icon_sprite.texture = item_texture
