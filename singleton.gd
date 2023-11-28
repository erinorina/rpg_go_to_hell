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


# QUICK COMBAT SCENE
var quick_combat_scene_instance
var quick_combat_scene = load("res://combat/quick_fight.tscn")
func switch_to_quick_combat_scene():
	add_quick_combat_scene()
	show_quick_combat_scene()
	
func add_quick_combat_scene():
	if quick_combat_scene_instance == null:
		quick_combat_scene_instance = quick_combat_scene.instantiate()
		get_tree().root.add_child(quick_combat_scene_instance)

func show_quick_combat_scene():
	quick_combat_scene_instance.visible = true
	for child in quick_combat_scene_instance.get_children():
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

'''
# FOREST MONSTERS RANDOM PICK PNG IN FOLDER
@onready var forest_monsters_0 = []
@onready var forest_monsters_0_random:String

@onready var forest_monsters_1 = []
@onready var forest_monsters_1_random:String

@onready var forest_monsters_2 = []
@onready var forest_monsters_2_random:String
# fuck ROOT BUG forest_monsters_2_random
#ERROR: No loader found for resource: res://.
#   at: _load (core/io/resource_loader.cpp:281)
#monster path /root/Singleton/monster

@onready var monster_glb = load("res://assets/monsters/monster.glb")
@onready var monster = monster_glb.instantiate()

func _ready():
	monster.transform.origin.z = -3
	add_child(monster)

	append_directory_png_textures("res://assets/monsters/forest_monsters_0/",forest_monsters_0)
	if forest_monsters_0.size() > 0:
		forest_monsters_0_random = forest_monsters_0[randi() % forest_monsters_0.size()]
	
	append_directory_png_textures("res://assets/monsters/forest_monsters_1/",forest_monsters_1)
	if forest_monsters_1.size() > 0:
		forest_monsters_1_random = forest_monsters_1[randi() % forest_monsters_1.size()]

	append_directory_png_textures("res://assets/monsters/forest_monsters_2_diff/",forest_monsters_2)
	if forest_monsters_2.size() > 0:
		forest_monsters_2_random = forest_monsters_2[randi() % forest_monsters_2.size()]
	
func _process(_delta):
	if forest_monsters_0.size() > 0:
		# fuck root cause forest_monsters_0_random is null
		forest_monsters_0_random = forest_monsters_0[randi() % forest_monsters_0.size()]
	if forest_monsters_1.size() > 0:
		forest_monsters_1_random = forest_monsters_1[randi() % forest_monsters_1.size()]
	if forest_monsters_2.size() > 0:
		forest_monsters_2_random = forest_monsters_2[randi() % forest_monsters_2.size()]

func append_directory_png_textures(_directory_of_png:String, _array:Array):
	var monster_path = _directory_of_png
	var directory = DirAccess.open(monster_path)
	if directory != null:
		directory.list_dir_begin()
		var file_name = directory.get_next()
		while file_name != "":
			if not directory.current_is_dir():
				var file = FileAccess.open(monster_path + file_name, FileAccess.READ)
				if file != null:
					var extension = file_name.get_extension()
					if extension == "png":
						_array.append(monster_path + file_name)
					file.close()
			file_name = directory.get_next()
		directory.list_dir_end()

'''
