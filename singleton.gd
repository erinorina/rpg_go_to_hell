extends Node


var player_stats = {
	"level": 0,
	"xp": 0,
	"life": 100,
	"attack":0
}

# RESSET PLAYER STATS
func reset_player_stats():
	player_stats["life"] = 100
	player_stats["xp"] = 0
	player_stats["level"] = 0
	player_stats["attack"] = 0

# HUD
var hud_scene_instance
var hud_scene = load("res://hud/hud.tscn")
func switch_to_hud_scene():
	add_hud_scene()
	show_hud_scene()

func add_hud_scene():
	if hud_scene_instance == null:
		hud_scene_instance = hud_scene.instantiate()
		add_child(hud_scene_instance)
		
func show_hud_scene():
	hud_scene_instance.visible = true
	for child in hud_scene_instance.get_children():
		child.visible = true


# MAIN MENU
var menu_scene_instance
var menu_scene = load("res://main/menu.tscn")
func switch_to_menu_scene():
	add_menu_scene()
	show_menu_scene()

func add_menu_scene():
	if menu_scene_instance == null:
		menu_scene_instance = menu_scene.instantiate()
		get_tree().root.add_child(menu_scene_instance)

func show_menu_scene():
	menu_scene_instance.visible = true
	for child in menu_scene_instance.get_children():
		child.visible = true


# COMBAT SCENE LEVEL 1
var combat_level_1_scene_instance
var combat_level_1_scene = load("res://combat_level_1/fight.tscn")
func switch_to_combat_level_1_scene():
	add_combat_level_1_scene()
	show_combat_level_1_scene()
	
func add_combat_level_1_scene():
	if combat_level_1_scene_instance == null:
		combat_level_1_scene_instance = combat_level_1_scene.instantiate()
#		get_tree().root.add_child(combat_level_1_scene_instance)
		self.add_child(combat_level_1_scene_instance) # Add the scene as a child of the current scene

func show_combat_level_1_scene():
	combat_level_1_scene_instance.visible = true
	for child in combat_level_1_scene_instance.get_children():
		child.visible = true
		
# COMBAT LOSS
var combat_loss_scene_instance			
var combat_loss_scene = preload("res://combat/loss.tscn")
func switch_to_combat_loss_scene():
	add_combat_loss_scene()
	show_combat_loss_scene()

func add_combat_loss_scene():
	if combat_loss_scene_instance == null:
		combat_loss_scene_instance = combat_loss_scene.instantiate()
		get_tree().root.add_child(combat_loss_scene_instance)

func show_combat_loss_scene():
	combat_loss_scene_instance.visible = true
	for child in combat_loss_scene_instance.get_children():
		child.visible = true


# EXPERIENCE SCENE
var experience_scene_instance
var experience_scene = load("res://experience/gain.tscn")
func switch_to_experience_scene():
	add_experience_scene()
	show_experience_scene()

func add_experience_scene():
	if experience_scene_instance == null:
		experience_scene_instance = experience_scene.instantiate()
		get_tree().root.add_child(experience_scene_instance)

func show_experience_scene():
	experience_scene_instance.visible = true
	for child in experience_scene_instance.get_children():
		child.visible = true


# EXPLORATION PLAIN
var exploration_plain_scene_instance
var exploration_plain_scene = load("res://exploration/plain.tscn")
func switch_to_exploration_plain():
	add_exploration_plain_scene()
	show_exploration_plain_scene()

func add_exploration_plain_scene():
	if exploration_plain_scene_instance == null:
		exploration_plain_scene_instance = exploration_plain_scene.instantiate()
		get_tree().root.add_child(exploration_plain_scene_instance)

func show_exploration_plain_scene():
	exploration_plain_scene_instance.visible = true
	for child in exploration_plain_scene_instance.get_children():
		child.visible = true


# forest
var forest_scene_instance
var forest_scene = load("res://assets/exploration/forest/world.tscn")
func switch_to_forest():
	add_forest_scene()
	show_forest_scene()
	
func clear_forest():
	if forest_scene_instance != null:
		forest_scene_instance.queue_free()

func add_forest_scene():
	if forest_scene_instance == null:
		forest_scene_instance = forest_scene.instantiate()
		get_tree().root.add_child(forest_scene_instance)

func show_forest_scene():
	forest_scene_instance.visible = true
	for child in forest_scene_instance.get_children():
		child.visible = true



# HELL
var hell_scene_instance
var hell_scene = load("res://assets/exploration/hell/world.tscn")
func switch_to_hell():
	add_hell_scene()
	show_hell_scene()

func add_hell_scene():
	if hell_scene_instance == null:
		hell_scene_instance = hell_scene.instantiate()
		get_tree().root.add_child(hell_scene_instance)

func show_hell_scene():
	hell_scene_instance.visible = true
	for child in hell_scene_instance.get_children():
		child.visible = true

