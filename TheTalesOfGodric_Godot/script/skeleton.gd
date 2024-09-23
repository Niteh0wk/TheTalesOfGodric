extends CharacterBody2D

@onready var skeleton_sprite: AnimatedSprite2D = $SkeletonSprite
@onready var progress_bar: ProgressBar = $ProgressBar

var health
var is_dead = false

func _ready() -> void:
	health = progress_bar.value

func _process(delta: float) -> void:
	progress_bar.value = health
	if progress_bar.value == 0 and not is_dead:
		is_dead = true
		skeleton_sprite.play("death")
	
func take_damage():
	skeleton_sprite.play("damage_taken")
	health -= 10


func _on_skeleton_sprite_animation_finished() -> void:
	if skeleton_sprite.animation == "damage_taken":
		skeleton_sprite.play("idle")
	elif skeleton_sprite.animation == "death":
		GameState.set_player_coins(GameState.get_player_coins() + 10)
		await get_tree().create_timer(0.5).timeout
		queue_free()
