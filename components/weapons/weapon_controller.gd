extends Sprite2D
class_name WeaponControl

@onready var ani: AnimationPlayer = $AnimationPlayer
var data: WeaponBase = preload("res://components/weapons/weapon_library/axe/starting_axe.tres"):
	set(value):
		texture = value.weapon_texture
