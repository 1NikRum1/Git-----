extends Node

@export var sword_ability: PackedScene

var damage = 5
var base_waite_time

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	base_waite_time = $Timer.wait_time
	$Timer.timeout.connect(on_timer_timeout)
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)

func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	var sword_instance = sword_ability.instantiate() as SwordAbility
	var foreground_layer = get_tree().get_first_node_in_group("foreground_layer")
	foreground_layer.add_child(sword_instance)
	#sword_instance.get_parent().add_child(sword_instance)
	sword_instance.hitbox_component.damage = damage
	if player.sprite_2d.flip_h == true:
		sword_instance.global_position = player.global_position 
		sword_instance.global_rotation_degrees = 180
		
	else:
		sword_instance.global_position = player.global_position
	
func on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	if upgrade.id != "sword_rate":
		return
	
	var percent_reduction = current_upgrades["sword_rate"]["quantity"] * .1
	$Timer.wait_time = base_waite_time * (1 - percent_reduction)
	$Timer.start()
	
	
	
	
	
	
	
	
	
	
