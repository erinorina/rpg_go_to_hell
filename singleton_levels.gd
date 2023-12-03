extends Node
@onready var singleton = Singleton

var scene_instances = {
	"plain":null,
	"forest": null,
	"hell": null
}

var scenes = {
	"plain": load("res://exploration/plain.tscn"),
	"forest": load("res://assets/exploration/forest/world.tscn"),
	"hell": load("res://assets/exploration/hell/world.tscn")
}



func _process(_delta):
	if singleton.player_stats["level"]==0:
		switch_to_scene("forest")
		
	if singleton.player_stats["level"]==1:
		clear_scene("forest")
		switch_to_scene("hell")
		
	if singleton.player_stats["level"]==2:
		clear_scene("hell")
		# etc ...



func switch_to_scene(scene_name):
	add_scene(scene_name)
	show_scene(scene_name)

func clear_scene(scene_name):
	if scene_instances[scene_name] != null:
		scene_instances[scene_name].queue_free()

func add_scene(scene_name):
	if scene_instances[scene_name] == null: # Invalid get index 'forest' (on base: 'Dictionary').
		scene_instances[scene_name] = scenes[scene_name].instantiate()
		get_tree().root.add_child(scene_instances[scene_name])

func show_scene(scene_name):
	scene_instances[scene_name].visible = true
	for child in scene_instances[scene_name].get_children():
		child.visible = true
